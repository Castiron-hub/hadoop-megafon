SELECT count(1) FROM mf_goryacheva.movies;


SELECT count(1) 
  FROM mf_goryacheva.movies_by_genre 
 WHERE genres = 'Horror' 
   AND year >= 1980 
   AND year <= 1990;


SELECT count(1) 
  FROM mf_goryacheva.movies
WHERE genres CONTAINS 'Horror'
  AND year >= 1980
  AND year <= 1990
ALLOW FILTERING;


SELECT min(avg_rnk) AS min_rnk, 
       avg(avg_rnk) AS avg_rnk, 
       max(avg_rnk) AS max_rnk 
  FROM mf_goryacheva.movies_by_genre_rating 
 WHERE genres = 'Sci-Fi' 
   AND year >= 2000;