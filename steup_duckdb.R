# setup_duckdb.R
library(DBI)
library(duckdb)
library(magick) #for converting image types

# Create and connect to the DuckDB file
con <- dbConnect(duckdb::duckdb(), "sitedata/photos.duckdb")

# Create the table
dbExecute(con, "
  CREATE TABLE IF NOT EXISTS photo_of_the_day (
    id INTEGER PRIMARY KEY,
    image_path TEXT,
    title TEXT,
    post_date DATE
  )
")


# View the table

# Connect to the DuckDB database
con <- dbConnect(duckdb::duckdb(), "sitedata/photos.duckdb")

# Query the table
photo_table <- dbGetQuery(con, "SELECT * FROM photo_of_the_day")

# Display the table
print(photo_table)


# Insert sample data
dbExecute(con, "
  INSERT INTO photo_of_the_day (id, image_path, title, post_date)
  VALUES (10, '/Users/michael/Desktop/Dev/Website/website/images/photo/daily/000001680016.tif',
        'Shoe Collab', '2024-11-26')
")

# Disconnect from the database
dbDisconnect(con)


# Update Record
dbExecute(con, "
UPDATE photo_of_the_day
SET image_path = '/images/photo/daily/000001680016.jpg',
post_date = '2024-12-17',
title = 'shoe collab'
WHERE id = 10;
")

# Disconnect from the database
dbDisconnect(con)



# Convert TIFF to JPEG

# Load the TIFF image
tiff_image <- image_read("/Users/michael/Desktop/Dev/Website/website/images/photo/daily/000001680016.tif")

# Save as JPEG
image_write(tiff_image, "/Users/michael/Desktop/Dev/Website/website/images/photo/daily/000001680016.jpg", format = "jpeg")
