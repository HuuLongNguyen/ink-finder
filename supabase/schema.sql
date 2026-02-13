-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Profiles (Public profiles linking to auth.users)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  phone_number TEXT,
  role TEXT CHECK (role IN ('customer', 'studio_owner', 'admin')) DEFAULT 'customer',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone" 
ON public.profiles FOR SELECT USING (true);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update own profile" 
ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- 2. Tattoo Styles (Global list of styles)
CREATE TABLE public.tattoo_styles (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  image_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Tattoo Styles
ALTER TABLE public.tattoo_styles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Styles are viewable by everyone" ON public.tattoo_styles FOR SELECT USING (true);

-- 3. Studios
CREATE TABLE public.studios (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  owner_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  bio TEXT,
  rating NUMERIC(3, 2) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
  reviews_count INTEGER DEFAULT 0,
  image_url TEXT, -- Cover image
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  is_premium BOOLEAN DEFAULT FALSE,
  starting_price INTEGER DEFAULT 0, -- In VND
  phone TEXT,
  zalo_id TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Studios
ALTER TABLE public.studios ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Studios are viewable by everyone" ON public.studios FOR SELECT USING (true);
CREATE POLICY "Studio owners can update their own studio" 
ON public.studios FOR UPDATE USING (auth.uid() = owner_id);
CREATE POLICY "Studio owners can insert their own studio" 
ON public.studios FOR INSERT WITH CHECK (auth.uid() = owner_id);

-- 4. Studio Gallery (Multiple images for a studio)
CREATE TABLE public.studio_gallery (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  studio_id UUID REFERENCES public.studios(id) ON DELETE CASCADE NOT NULL,
  image_url TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Gallery
ALTER TABLE public.studio_gallery ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Gallery images are viewable by everyone" ON public.studio_gallery FOR SELECT USING (true);
CREATE POLICY "Studio owners can manage their gallery" 
ON public.studio_gallery FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.studios 
    WHERE public.studios.id = public.studio_gallery.studio_id 
    AND public.studios.owner_id = auth.uid()
  )
);

-- 5. Artists
CREATE TABLE public.artists (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  studio_id UUID REFERENCES public.studios(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  bio TEXT,
  avatar_url TEXT,
  instagram_handle TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Artists
ALTER TABLE public.artists ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Artists are viewable by everyone" ON public.artists FOR SELECT USING (true);
CREATE POLICY "Studio owners can manage their artists" 
ON public.artists FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.studios 
    WHERE public.studios.id = public.artists.studio_id 
    AND public.studios.owner_id = auth.uid()
  )
);

-- 6. Studio Styles (Junction table)
CREATE TABLE public.studio_styles (
  studio_id UUID REFERENCES public.studios(id) ON DELETE CASCADE,
  style_id UUID REFERENCES public.tattoo_styles(id) ON DELETE CASCADE,
  PRIMARY KEY (studio_id, style_id)
);

-- RLS for Studio Styles
ALTER TABLE public.studio_styles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Studio styles are viewable by everyone" ON public.studio_styles FOR SELECT USING (true);
CREATE POLICY "Studio owners can manage their styles" 
ON public.studio_styles FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.studios 
    WHERE public.studios.id = public.studio_styles.studio_id 
    AND public.studios.owner_id = auth.uid()
  )
);

-- 7. Bookings
CREATE TABLE public.bookings (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  customer_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  studio_id UUID REFERENCES public.studios(id) ON DELETE CASCADE NOT NULL,
  artist_id UUID REFERENCES public.artists(id) ON DELETE SET NULL, -- specific artist optional
  status TEXT CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')) DEFAULT 'pending',
  booking_date TIMESTAMPTZ NOT NULL, -- Date requested
  description TEXT, -- Tattoo description/placement
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS for Bookings
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- Customers can view their own bookings
CREATE POLICY "Customers can view own bookings" 
ON public.bookings FOR SELECT USING (auth.uid() = customer_id);

-- Studio owners can view bookings for their studio
CREATE POLICY "Studio owners can view studio bookings" 
ON public.bookings FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.studios 
    WHERE public.studios.id = public.bookings.studio_id 
    AND public.studios.owner_id = auth.uid()
  )
);

-- Customers can creates bookings
CREATE POLICY "Customers can create bookings" 
ON public.bookings FOR INSERT WITH CHECK (auth.uid() = customer_id);

-- Update status (Studio Owner or Customer cancelling)
CREATE POLICY "Studio owners can update booking status" 
ON public.bookings FOR UPDATE USING (
  EXISTS (
    SELECT 1 FROM public.studios 
    WHERE public.studios.id = public.bookings.studio_id 
    AND public.studios.owner_id = auth.uid()
  )
);
-- Allow customer to cancel (update status to cancelled) if pending
-- (Simplified for now, just allow customer to update their own booking)
CREATE POLICY "Customers can update own bookings" 
ON public.bookings FOR UPDATE USING (auth.uid() = customer_id);


-- Triggers for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_profiles_modtime BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
CREATE TRIGGER update_studios_modtime BEFORE UPDATE ON public.studios FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
CREATE TRIGGER update_artists_modtime BEFORE UPDATE ON public.artists FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
CREATE TRIGGER update_bookings_modtime BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


-- Seed Data (Optional, based on Mock Data in Code)
-- Note: UUIDs would need to be real UUIDs for this to work perfectly in copy-paste, 
-- but this serves as a template.

/*
INSERT INTO public.tattoo_styles (name, image_url) VALUES
('Traditional', 'https://images.unsplash.com/photo-1598371839696-5c5bb00bdc28?q=80&w=2671&auto=format&fit=crop'),
('Blackwork', 'https://images.unsplash.com/photo-1611501275019-9b5cda974a42?q=80&w=2574&auto=format&fit=crop'),
('Realism', 'https://images.unsplash.com/photo-1562962230-16e4623d36e6?q=80&w=2574&auto=format&fit=crop'),
('Japanese', 'https://images.unsplash.com/photo-1560707303-4e9803d16649?q=80&w=2669&auto=format&fit=crop');
*/
