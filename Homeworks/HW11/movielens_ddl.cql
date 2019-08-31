CREATE KEYSPACE IF NOT EXISTS mf_goryacheva 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};

CREATE TABLE mf_goryacheva.movies (
    movieid int,
    title text,
    year int,
    genres set<text>,
    PRIMARY KEY (title, year, movieid)
);

CREATE TABLE mf_goryacheva.movies_by_genre (
    genres text, 
    movieid int, 
    year int, 
    title text, 
    PRIMARY KEY (genres, year, movieid)
);

CREATE INDEX genres_idx ON mf_goryacheva.movies (genres);

CREATE TABLE mf_goryacheva.movies_by_genre_rating (
    genres text, 
    movieid int, 
    year int, 
    title text, 
    avg_rnk float,
    PRIMARY KEY (genres, year, movieid) 
);