CREATE TABLE IF NOT EXISTS Band (
    band_id TEXT PRIMARY KEY,
    name TEXT,
    genre TEXT
);

INSERT INTO Band VALUES('1', 'Кровосток', 'Абстрактный хип-хоп') ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS Album (
    album_id TEXT PRIMARY KEY,
    band_id REFERENCES Band(band_id) ON DELETE CASCADE,
    name TEXT,
    date_released INTEGER
);

INSERT INTO Album VALUES('1', '1', 'Гантеля', 2008) ON CONFLICT DO NOTHING;
INSERT INTO Album VALUES('2', '1', 'Студень', 2012) ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS Musician (
    musician_id TEXT PRIMARY KEY,
    name TEXT
);

INSERT INTO Musician VALUES('1', 'Антон Черняк') ON CONFLICT DO NOTHING;  
INSERT INTO Musician VALUES('2', 'Дмитрий Файн') ON CONFLICT DO NOTHING;  
INSERT INTO Musician VALUES('3', 'Константин Копчик') ON CONFLICT DO NOTHING;  

CREATE TABLE IF NOT EXISTS Song (
    album_id REFERENCES Album(album_id),
    song_id TEXT PRIMARY KEY,
    name TEXT,
    DURATION INTEGER,
    lyrics_author REFERENCES Musician(musician_id) ON DELETE RESTRICT,
    music_author REFERENCES Musician(musician_id)
);

INSERT INTO Song VALUES('1', '1', 'Память', 3, '2', '3') ON CONFLICT DO NOTHING;
INSERT INTO Song VALUES('1', '2', 'Овощ', 3, '2', '3') ON CONFLICT DO NOTHING;
INSERT INTO Song VALUES('1', '3', 'Цветы в вазе', 2, '2', '3') ON CONFLICT DO NOTHING;
INSERT INTO Song VALUES('2', '4', 'Колхозники', 2, '2', '3') ON CONFLICT DO NOTHING;
INSERT INTO Song VALUES('2', '5', 'Метадон', 3, '2', '3') ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS Musician_band (
    musician_id REFERENCES Musician(musician_id) ON DELETE RESTRICT,
    band_id REFERENCES Band(band_id) ON DELETE CASCADE,
    started_at INTEGER,
    finished_at INTEGER,
    instrument TEXT
);

INSERT INTO Musician_band VALUES('1', '1', 2003, NULL, 'вокалист') ON CONFLICT DO NOTHING;
INSERT INTO Musician_band VALUES('2', '1', 2003, NULL, 'автор текстов') ON CONFLICT DO NOTHING;
INSERT INTO Musician_band VALUES('3', '1', 2007, NULL, 'битмейкер') ON CONFLICT DO NOTHING