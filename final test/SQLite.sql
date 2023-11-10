-- Create dimension table dim_user
CREATE TABLE dim_user AS
SELECT
  user_id,
  user_name,
  country
FROM raw_users;

-- Create dimension table dim_post
CREATE TABLE dim_post AS
SELECT
  post_id,
  post_text,
  post_date,
  user_id
FROM raw_posts;

-- Create dimension table dim_date
CREATE TABLE dim_date AS
SELECT DISTINCT
  post_date AS date
FROM raw_posts;

-- Create fact table fact_post_performance
CREATE TABLE fact_post_performance AS
SELECT
  dp.post_id,
  dd.date,
  COUNT(rl.like_id) AS likes,
  COUNT(fp.post_id) AS views
FROM dim_post dp
CROSS JOIN dim_date dd
LEFT JOIN raw_likes rl ON dp.post_id = rl.post_id AND dd.date = rl.like_date
LEFT JOIN raw_posts fp ON dp.post_id = fp.post_id AND dd.date = fp.post_date
GROUP BY dp.post_id, dd.date;

-- Create fact table fact_daily_posts
CREATE TABLE fact_daily_posts AS
SELECT
  dp.user_id,
  dp.post_date AS date,
  COUNT(dp.post_id) AS posts
FROM raw_posts dp
GROUP BY dp.user_id, dp.post_date;
