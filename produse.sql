DROP TYPE IF EXISTS categ_zona;
DROP TYPE IF EXISTS tipuri_produse;

CREATE TYPE categ_zona AS ENUM( 'ochi', 'fata', 'buze');
CREATE TYPE tipuri_produse AS ENUM('palete de farduri', 'creioane de ochi', 'sprancene', 'mascara', 'fonduri de ten', 'iluminatoare', 'corectoare', 'conturarea fetei', 'blush', 'pudra', 'rujuri', 'lip gloss', 'balsamuri de buze', 'creioane de buze');


CREATE TABLE IF NOT EXISTS machiaje (
   id serial PRIMARY KEY,
   nume VARCHAR(50) UNIQUE NOT NULL,
   descriere TEXT,
   pret NUMERIC(8,2) NOT NULL,
   cantitate INT NOT NULL CHECK (cantitate>=0),   
   tip_culori VARCHAR(50) NOT NULL,
   tip_produs tipuri_produse DEFAULT 'palete de farduri',
   nr_bucati INT NOT NULL CHECK (nr_bucati>=0),
   categorie categ_zona DEFAULT 'ochi',
   culori VARCHAR [], --pot sa nu fie specificare deci nu punem NOT NULL
   produs_vegan BOOLEAN NOT NULL DEFAULT TRUE,
   imagine VARCHAR(300),
   data_adaugare TIMESTAMP DEFAULT current_timestamp
);

INSERT into machiaje (nume, descriere, pret, cantitate, tip_culori, nr_bucati, tip_produs, categorie, culori, produs_vegan, imagine) VALUES 
('Paleta de machiaj Colourful Palette 1', 'Paleta de machiaj in culori naturale, calde.', 50 , 20, 'calde', 500, 'palete de farduri', 'ochi', '{"nud","maro","negru","alb"}', True, 'paleta1.jpg'),

('Paleta de machiaj Colourful Palette 2', 'Paleta de machiaj in culori diverse, curcubeu.', 100 , 50, 'mixte', 400, 'palete de farduri', 'ochi', '{"nud","maro","negru","alb","rosu","albastru","verde","roz","mov","galben"}', True, 'paleta2.jpg'),

('Paleta de machiaj Colourful Palette 3', 'Paleta de machiaj in culori naturale, reci.', 50 , 20, 'reci', 450, 'palete de farduri', 'ochi', '{"nud","maro","negru","alb","roz"}', True, 'paleta3.jpg'),

('Creion de ochi Colourful Eyes', 'Creion de ochi de culoare albastru deschis.', 10 , 2, 'reci', 100, 'creioane de ochi', 'ochi', '{"albastru","negru"}', False,'creion_ochi.png'),

('Creion pentru sprancene Colourful Brows', 'Creion pentru sprancene, perfect pentru toate tipurile.', 30 , 2, 'reci', 100, 'sprancene', 'ochi', '{"maro","negru", "nud"}', False,'creion_sprancene.jpg'),

('Mascara Colourful Lash 1', 'Mascara pentru volum.', 20 , 10, 'reci', 540, 'mascara', 'ochi', '{"maro","negru"}', True,'rimel1.jpg'),

('Mascara Colourful Lash 2', 'Mascara pentru alungire.', 20 , 10, 'reci', 440, 'mascara', 'ochi', '{"maro","negru"}', True,'rimel2.jpg'),

('Mascara Colourful Lash 3', 'Mascara cu efect de gene false.', 20 , 10, 'reci', 400, 'mascara', 'ochi', '{"maro","negru"}', True,'rimel3.jpg'),

('Fond de ten Colourful Face', 'Fond de ten cu efect matifiant.', 60 , 30, 'calde', 660, 'fonduri de ten', 'fata', '{"maro","nud","alb","roz"}', True,'ten.png'),

('Iluminator Colourful Glow', 'Iluminator perfect pentru toate tipurile de ten.', 70 , 25, 'reci', 300, 'iluminatoare', 'fata', '{"alb","nud","roz"}', True,'iluminator.jpg'),

('Corector Colourful Conceal', 'Corector pentru acoperirea imperfectiunilor.', 55 , 45, 'mixte', 500, 'corectoare', 'fata', '{"alb","nud","roz","verde","maro"}', True,'corector.jpg'),

('Perle de contur Colourful Bronzer', 'Perle de contur, cu efect brozant.', 65 , 35, 'calde', 350, 'conturarea fetei', 'fata', '{"nud","roz","maro"}', True,'Perle de contur.jpg'),

('Blush Colourful Cheeks', 'Blush ce ofera dimensiune fetei, cu efect natural.', 30 , 20, 'calde', 400, 'blush', 'fata', '{"nud","roz","rosu"}', True,'blush.jpg'),

('Pudra Colourful Finish', 'Pudra ce reduce efectul de sebum.', 50 , 45, 'calde', 555, 'pudra', 'fata', '{"nud","roz","alb"}', True,'pudra.jpg'),

('Ruj Colourful Nude', 'Ruj nude hidratant.', 40 , 35, 'calde', 600, 'rujuri', 'buze', '{"nud","roz"}', False,'ruj1.jpg'),

('Ruj Colourful Matte', 'Ruj mat, rezistent la transfer.', 40 , 35, 'calde', 500, 'rujuri', 'buze', '{"nud","roz"}', False,'ruj2.jpg'),

('Ruj Colourful Intense Red', 'Ruj rosu intens, pigmentat.', 40 , 35, 'calde', 500, 'rujuri', 'buze', '{"nud","roz","rosu"}', False,'ruj3.jpg'),

('Lip Gloss Colourful Shine', 'Lip gloss cu stralucire intensa.', 30 , 30, 'reci', 300, 'lip gloss', 'buze', '{"nud","roz","rosu","alb"}', True,'gloss.jpg'),

('Balsam de buze Colourful Moisturizer', 'Balsam de buze foarte hidratant.', 15 , 30, 'reci', 350, 'balsamuri de buze', 'buze', '{"nud","roz","alb"}', True,'balsam.jpg'),

('Creion de buze Colourful Lips', 'Creion de buze in diferite nuante.', 15 , 20, 'calde', 400, 'creioane de buze', 'buze', '{"nud","roz","rosu"}', True,'creion_buze.jpg');