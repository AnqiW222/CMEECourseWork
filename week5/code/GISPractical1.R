################################################################################
#######################                                    #####################
###################### Practical One: GIS data and plotting ####################
#######################                                    #####################
################################################################################
## Author: Anqi Wang 
##
## Date Created: Oct, 2022
##
## Email: aw222@ic.ac.uk

# Load the packages
library(terra)     # core raster GIS package
library(sf)        # core vector GIS package
library(units)     # used for precise unit conversion

library(geodata)   # Download and load functions for core datasets
library(openxlsx)  # Reading data from Excel files

# Turn off an advanced feature used by the sf package
sf_use_s2(FALSE)

# Always have a clean workplace
rm(list = ls())
#################
## Vector Data ##
#################

## Making vectors from coordinates ##
# Create a population density map for the British lsles #
pop_dens <- data.frame(
  n_km2 = c(260, 67,151, 4500, 133), 
  country = c('England','Scotland', 'Wales', 'London', 'Northern Ireland')
)
print(pop_dens)

# simple polygons to show the countries #
# Create coordinates  for each country 
# - this creates a matrix of pairs of coordinates forming the edge of the polygon. 
# - note that they have to _close_: the first and last coordinate must be the same.
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))

# Convert these coordinates into feature geometries #
# - these are simple coordinate sets with no projection information
scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# Combine these into a simple feature column (sfc). 
# Use the list of geometries to include vector data in a normal R data.frame, 
# also used to set the coordinate reference system (crs or projection) of the data.

# Combine geometries into a simple feature column
uk_eire_sfc <- st_sfc(wales, england, scotland, ireland, crs=4326)
plot(uk_eire_sfc, asp=1) 
# sf automatically tries to scale the aspect ratio of plots of geographic coordinate data 
# (coordinates are latitude and longitude) based on their latitude - this makes them look less squashed. 
# We are actively suppressing that here by setting an aspect ratio of one (asp=1).

## Making vector points from a dataframe ##

# Creates point locations for capital cities #
uk_eire_capitals <- data.frame(
  long= c(-0.1, -3.2, -3.2, -6.0, -6.25),
  lat=c(51.5, 51.5, 55.8, 54.6, 53.30),
  name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin')
)

# Indicate which fields in the data frame contain the coordinates
uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long','lat'), crs=4326)
print(uk_eire_capitals)

# Vector Geometry operations #
# Current issues: 1. missing separate polygon for London
# 2. The boundary for Wales is poorly digitized - we want a common border with England.
# 3. Northern Ireland has not separated from Eire. #

# use the buffer operation to create a polygon for London, which we define as anywhere within a quarter degree of St. Pauls Cathedral. 
st_pauls <- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25)

# use the difference operation to remove London from England polygon
england_no_london <- st_difference(england, london) # the order of the argument matters!!!

# lengths function allows to see the number of components in polygon and how many in each
lengths(scotland)
# a single component with 18 points
lengths(england_no_london)

# use the same operation to tidy up Wales: in this case we want the bits of Wales that are different from England.
wales <- st_difference(wales, england)
# use the intersection operation to separate Northern Ireland from the island of Ireland.
# A rough polygon that includes Northern Ireland and surrounding sea.
# - not the alternative way of providing the coordinates
ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))

northern_ireland <- st_intersection(ireland, ni_area)
eire <- st_difference(ireland, ni_area)

# Combine the final geometries
uk_eire_sfc <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs=4326)
# plot(uk_eire_sfc)

## Features and geometries ##
# create a single feature that contains all of those geometries in one MULTIPOLYGON geometry by using the union operation
# compare six Polygon features with one Multipolygon feature
print(uk_eire_sfc)
# make the UK into a single feature
uk_country <- st_union(uk_eire_sfc[-6])
print(uk_country)
# Plot them
par(mfrow=c(1, 2), mar=c(3,3,1,1))
plot(uk_eire_sfc, asp=1, col=rainbow(6))
plot(st_geometry(uk_eire_capitals), add=TRUE)
plot(uk_country, asp=1, col='lightblue')

## Vector data and attribute ##
# The sf package does this using the sf object type: 
# basically this is just a normal data frame with that additional field containing simple feature data. 
# We can do that here - printing the object shows some extra information compared to a basic data.frame.
uk_eire_sf <- st_sf(name=c('Wales', 'England','Scotland', 'London', 
                           'Northern Ireland', 'Eire'),
                    geometry=uk_eire_sfc)

print(uk_eire_sf)
# An sf object also has a simple plot method, which we can use to draw a basic map
plot(uk_eire_sf['name'], asp=1)
# Since an sf object is an extended data frame, we can add attributes by adding fields directly:
uk_eire_sf$capital <- c('Cardiff', 'London', 'Edinburgh', 
                        NA, 'Belfast','Dublin')
print(uk_eire_sf)
# The merge function allows us to set columns in two data frames that containing matching values and uses those to merge the data together.
uk_eire_sf <- merge(uk_eire_sf, pop_dens, by.x='name', by.y='country', all.x=TRUE)
print(uk_eire_sf)

## Spatial attribute ##
#  the centroids of features.
uk_eire_centroids <- st_centroid(uk_eire_sf)
st_coordinates(uk_eire_centroids)

# Two other simple ones are the length of a feature and its area. 
# A given goegraphic coordinate system and instead uses internal transformations 
# to give us back accurate distances and areas using metres. 
# Under the hood, it is using calculations on the surface of a sphere, so called great circle distances.
uk_eire_sf$area <- st_area(uk_eire_sf)

# To calculate a 'length' of a polygon, you have to convert it to a LINESTRING or a 
# MULTILINESTRING. Using MULTILINESTRING will automatically include all perimeter of a 
# polygon (including holes).
uk_eire_sf$length <- st_length(st_cast(uk_eire_sf, 'MULTILINESTRING'))

# Look at the result
print(uk_eire_sf)

# You can change units in a neat way
uk_eire_sf$area <- set_units(uk_eire_sf$area, 'km^2')
uk_eire_sf$length <- set_units(uk_eire_sf$length, 'km')
print(uk_eire_sf)

# And it won't let you make silly error like turning a length into weight
uk_eire_sf$area <- set_units(uk_eire_sf$area, 'kg')

# Or you can simply convert the `units` version to simple numbers
uk_eire_sf$length <- as.numeric(uk_eire_sf$length)
#print(uk_eire_sf)

# A final useful example is the distance between objects: 
# sf gives us the closest distance between geometries, 
# which might be zero if two features overlap or touch, as in the neighbouring polygons in our data
st_distance(uk_eire_sf)
# sf is noting that we have a geographic coordinate system and internally calculating distances in metres.
st_distance(uk_eire_centroids)

## Plottng sf objects ##
# pick a single field to plot by using square brackets
plot(uk_eire_sf['n_km2'], asp=1)
# You could simply log the data:
uk_eire_sf$log_n_km2 <- log10(uk_eire_sf$n_km2)
plot(uk_eire_sf['log_n_km2'], asp=1, key.pos=4)
# Or you can have logarithimic labelling using logz
plot(uk_eire_sf['n_km2'], asp=1, logz=TRUE, key.pos=4)

## Reprojecting vector data ##
# reproject our UK and Eire map onto a good choice of local projected coordinate system: 
# British National Grid (EPSG:27700)
uk_eire_BNG <- st_transform(uk_eire_sf, 27700)
# UTM50N (EPSG:32650)
uk_eire_UTM50N <- st_transform(uk_eire_sf, 32650)
# The bounding boxes of the data shows the change in units
st_bbox(uk_eire_sf)
st_bbox(uk_eire_BNG)
# using the st_geometry function to only plot the geometry data and not a particular attribute
# Plot the results
par(mfrow=c(1, 3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire_sf), asp=1, axes=TRUE, main='WGS 84')
plot(st_geometry(uk_eire_BNG), axes=TRUE, main='OSGB 1936 / BNG')
plot(st_geometry(uk_eire_UTM50N), axes=TRUE, main='UTM 50N')

# Proj4 strings #

# Degrees are not constant #
# Set up some points separated by 1 degree latitude and longitude from St. Pauls
st_pauls <- st_sfc(st_pauls, crs=4326)
one_deg_west_pt <- st_sfc(st_pauls - c(1, 0), crs=4326) # near Goring
one_deg_north_pt <-  st_sfc(st_pauls + c(0, 1), crs=4326) # near Peterborough
# Calculate the distance between St Pauls and each point
st_distance(st_pauls, one_deg_west_pt)
st_distance(st_pauls, one_deg_north_pt)
st_distance(st_transform(st_pauls, 27700), 
            st_transform(one_deg_west_pt, 27700))

# transform St Pauls to BNG and buffer using 25 km
london_bng <- st_buffer(st_transform(st_pauls, 27700), 25000)
# In one line, transform england to BNG and cut out London
england_not_london_bng <- st_difference(st_transform(st_sfc(england, crs=4326), 27700), london_bng)
# project the other features and combine everything together
others_bng <- st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs=4326), 27700)
corrected <- c(others_bng, london_bng, england_not_london_bng)
# Plot that and marvel at the nice circular feature around London
par(mar=c(3,3,1,1))
plot(corrected, main='25km radius London', axes=TRUE)

############
## Raster ##
############
# par(mfrow = c(1,1)) # set the plot format, only print one plot in a page
## Creating a raster ##
# Create an empty raster object covering UK and Eire
uk_raster_WGS84 <- rast(xmin=-11,  xmax=2,  ymin=49.5, ymax=59, 
                        res=0.5, crs="EPSG:4326")
hasValues(uk_raster_WGS84)
# Add data to the raster - just use the cell numbers
values(uk_raster_WGS84) <- cells(uk_raster_WGS84)
print(uk_raster_WGS84)
# create a basic map of that, with the country borders over the top: 
# add=TRUE adds the vector data to the existing map and the other options set border and fill colours. 
# The ugly looking #FFFFFF44 is a RGBA colour code that gives us a transparent gray fill for the polygon.
plot(uk_raster_WGS84)
plot(st_geometry(uk_eire_sf), add=TRUE, border='black', lwd=2, col='#FFFFFF44')

## Changing raster resolution ##
# Define a simple 4 x 4 square raster
m <- matrix(c(1, 1, 3, 3,
              1, 2, 4, 3,
              5, 5, 7, 8,
              6, 6, 7, 7), ncol=4, byrow=TRUE)
square <- rast(m)

plot(square, legend=NULL)
text(square, digits=2)

## Aggregating rasters ##
# With aggregating, we choose an aggregation factor - how many cells to group - and then lump sets of cells together.
# Average values
square_agg_mean <- aggregate(square, fact=2, fun=mean)
plot(square_agg_mean, legend=NULL)
text(square_agg_mean, digits=2)
# Maximum values
square_agg_max <- aggregate(square, fact=2, fun=max)
plot(square_agg_max, legend=NULL)
text(square_agg_max, digits=2)
# Modal values for categories
square_agg_modal <- aggregate(square, fact=2, fun='modal')
plot(square_agg_modal, legend=NULL)
text(square_agg_modal, digits=2)

## Disaggregating rasters ##
# The disaggregate function also requires a factor, but this time the factor is the square root of the number of cells 
# to create from each cell, rather than the number to merge. 
# There is again a choice to make on what values to put in the cell.
# Simply duplicate the nearest parent value
square_disagg <- disagg(square, fact=2, method='near')
plot(square_disagg, legend=NULL)
text(square_disagg, digits=2)
# Another option is to interpolate between the values to provide a smoother gradient between cells.
# This does not make sense for a categorical variable.
# Use bilinear interpolation
square_interp <- disagg(square, fact=2, method='bilinear')
plot(square_interp, legend=NULL)
text(square_interp, digits=1)

## Resampling ##
## Reprojecting a raster ##
# It can’t be displayed using actual raster data because they always need to plot on a regular grid.
# However,  create vector grids, and using the new function st_make_grid and other vector tools, to represent the cell edges in the two raster grids so overplot them.
# make two simple `sfc` objects containing points in  the
# lower left and top right of the two grids
uk_pts_WGS84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2, 59)), crs=4326)
uk_pts_BNG <- st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs=27700)

#  Use st_make_grid to quickly create a polygon grid with the right cellsize
uk_grid_WGS84 <- st_make_grid(uk_pts_WGS84, cellsize=0.5)
uk_grid_BNG <- st_make_grid(uk_pts_BNG, cellsize=1e5)

# Reproject BNG grid into WGS84
uk_grid_BNG_as_WGS84 <- st_transform(uk_grid_BNG, 4326)

# Plot the features
par(mar=c(0,0,0,0))
plot(uk_grid_WGS84, asp=1, border='grey', xlim=c(-13,4))
plot(st_geometry(uk_eire_sf), add=TRUE, border='darkgreen', lwd=2)
plot(uk_grid_BNG_as_WGS84, border='red', add=TRUE)

# use the project function, which gives us the choice of interpolating a representative value from the source data (method='bilinear') 
# or picking the cell value from the nearest neighbour to the new cell centre (method='near').
# Create the target raster
uk_raster_BNG <- rast(xmin=-200000, xmax=700000, ymin=0, ymax=1000000,
                      res=100000, crs='+init=EPSG:27700')
uk_raster_BNG_interp <- project(uk_raster_WGS84, uk_raster_BNG, method='bilinear')
uk_raster_BNG_near <- project(uk_raster_WGS84, uk_raster_BNG, method='near')
# Check and run
par(mfrow=c(1,2), mar=c(0,0,0,0))
plot(uk_raster_BNG_interp, main='Interpolated', axes=FALSE, legend=FALSE)
text(uk_raster_BNG_interp, digit=1)
plot(uk_raster_BNG_near, main='Nearest Neighbour',axes=FALSE, legend=FALSE)
text(uk_raster_BNG_near)

#####################################################
## Converting between vector and raster data types ##
#####################################################

## Vector to raster ##
# Converting vector data to a raster is a bit like reprojectRaster:
# you provide the target raster and the vector data and put it all through the rasterize function. 
# POINT: If a point falls anywhere within a cell, that value is assigned to the cell.
# LINESTRING: If any part of the linestring falls within a cell, that value is assigned to the cell.
# POLYGON: If the centre of the cell falls within a polygon, the value from that polygon is assigned to the cell.
# Create the target raster 
uk_20km <- rast(xmin=-200000, xmax=650000, ymin=0, ymax=1000000, 
                res=20000, crs='+init=EPSG:27700')

# Rasterizing polygons
uk_eire_poly_20km  <- rasterize(uk_eire_BNG, uk_20km, field='name')

plot(uk_eire_poly_20km)

# Getting raster versions of polygons is by far the most common use case, 
# but it is also possible to represent the boundary lines or even the polygon vertices as raster data.
# recast the polygon data, so that the rasterisation process knows to treat the data differently:
# the list of polygon vertices no longer form a closed loop (a polygon), but form a linear feature or a set of points.
# the sf package is the sheer quantity of warnings it will issue to avoid making errors. 
uk_eire_BNG$name <- as.factor(uk_eire_BNG$name)
st_agr(uk_eire_BNG) <- 'constant'

# Rasterizing lines.
uk_eire_BNG_line <- st_cast(uk_eire_BNG, 'LINESTRING')
uk_eire_line_20km <- rasterize(uk_eire_BNG_line, uk_20km, field='name')

# Rasterizing points 
# - This isn't quite as neat as there are two steps in the casting process:
#   Polygon -> Multipoint -> Point
uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, 'MULTIPOINT'), 'POINT')
uk_eire_point_20km <- rasterize(uk_eire_BNG_point, uk_20km, field='name')

# Plotting those different outcomes
# - Use the hcl.colors function to create a nice plotting palette
color_palette <- hcl.colors(6, palette='viridis', alpha=0.5)

# - Plot each raster
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(uk_eire_poly_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

plot(uk_eire_line_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')

plot(uk_eire_point_20km, col=color_palette, legend=FALSE, axes=FALSE)
plot(st_geometry(uk_eire_BNG), add=TRUE, border='red')
# the differences between the polygon and line outputs. To recap:
# for polygons, cells are only included if the cell centre falls in the polygon, and
# for lines, cells are included if the line touches the cell at all.

## Raster to vector ##
# Converting a raster to vector data involves making a choice.
# A raster cell can either be viewed as a polygon with a value representing the whole cell or a point with the value representing the value at a specific location. 
# Note that it is uncommon to have raster data representing linear features and it is not trivial to turn raster data into LINESTRING vector data.

# The terra package provides functions to handle both of these: for polygons 
# whether to dissolve cells with identical values into larger polygons, or leave them all as individual cells.
# Get a set of dissolved polygons (the default) including NA cells
poly_from_rast <- as.polygons(uk_eire_poly_20km, na.rm=FALSE)

# Get individual cells (no dissolving)
cells_from_rast <- as.polygons(uk_eire_poly_20km, dissolve=FALSE)

# Get individual points
points_from_rast <- as.points(uk_eire_poly_20km)

#The terra package has its own format (SpatVector) for vector data, but it is easy to transform that back to the more familiar sf object,
# to see what the outputs contain:
#  the dissolved polygons have the original 6 features plus 1 new feature for the NA values,
#  the undissolved polygons and points both have 817 features - one for each grid cell in the raster that does not contain an NA value.
print(st_as_sf(poly_from_rast))
print(st_as_sf(cells_from_rast))
print(st_as_sf(points_from_rast))
# Plot the outputs - using key.pos=NULL to suppress the key
par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(poly_from_rast, key.pos = NULL)
plot(cells_from_rast, key.pos = NULL)
plot(points_from_rast, key.pos = NULL, pch=4)

#########################
## Using data in files ##
#########################
# st_read function in sf --> vector
# rast() in terra --> raster 

## Saving vector data ##
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.shp')
st_write(uk_eire_BNG, '../data/uk/uk_eire_BNG.shp')
# a shapefile is not a single file. A shapefile consists of a set of files: they all have the same name but different file suffixes
# and (at least) the files ending with .prj, .shp, .shx and .dbf, which is what st_write has created.

# GeoJSON stores the coordinates and attributes in a single text file: 
# it is technically human readable but you have to be familiar with JSON data structures.
# GeoPackage stores vector data in a single SQLite3 database file. 
# There are multiple tables inside this file holding various information about the data, but it is very portable and in a single file.
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.geojson')
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.gpkg')
# The sf package will try and choose the output format based on the file suffix (so .shp gives ESRI Shapefile)
st_write(uk_eire_sf, '../data/uk/uk_eire_WGS84.json', driver='GeoJSON')

## Saving raster data ##
# The GeoTIFF file format is one of the most common GIS raster data formats. 
#It is basically the same as a TIFF image file but contains embedded data describing the origin, resolution and coordinate reference system of the data. 
# Sometimes, a .tfw file: this is a ‘world’ file that contains the same information and should probably keep it with the TIFF file.
# Save a GeoTiff
writeRaster(uk_raster_BNG_interp, '../data/uk/uk_raster_BNG_interp.tif')
# Save an ASCII format file: human readable text. 
# Note that this format also creates an aux.xml and .prj file!
writeRaster(uk_raster_BNG_near, '../data/uk/uk_raster_BNG_ngb.asc', filetype='AAIGrid')

## Loading Vector data ##
# Load a vector shapefile
ne_110 <- st_read('../data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp')
# Also load some WHO data on 2016 life expectancy
# see: http://apps.who.int/gho/athena/api/GHO/WHOSIS_000001?filter=YEAR:2016;SEX:BTSX&format=csv
life_exp <- read.csv(file = "../data/WHOSIS_000001.csv")
# Generate two stacked plots with narrow margins
par(mfrow=c(2,1), mar=c(1,1,1,1))

# The first plot is easy
plot(ne_110['GDP_MD'],  asp=1, main='Global GDP', logz=TRUE, key.pos=4)

# Then for the second we need to merge the data
ne_110 <- merge(ne_110, life_exp, by.x='ISO_A3_EH', by.y='COUNTRY', all.x=TRUE)
# Create a sequence of break values to use for display
bks <- seq(50, 85, by=0.25)
# Plot the data
plot(ne_110['Numeric'], asp=1, main='Global 2016 Life Expectancy (Both sexes)',
     breaks=bks, pal=hcl.colors, key.pos=4)

## Loading XY data ##
# Read in Southern Ocean example data
so_data <- read.csv('../data/Southern_Ocean.csv', header=TRUE)

# Convert the data frame to an sf object
so_data <- st_as_sf(so_data, coords=c('long', 'lat'), crs=4326)
print(so_data)

## Loading Raster data ##
etopo_25 <- rast('../data/etopo_25.tif')
# Look at the data content
print(etopo_25)
# Plot it 
plot(etopo_25, plg=list(ext=c(190, 200, -90, 90)))
# controlling raster plots
bks <- seq(-10000, 6000, by=250)
land_cols  <- terrain.colors(24)
sea_pal <- colorRampPalette(c('darkslateblue', 'steelblue', 'paleturquoise'))
sea_cols <- sea_pal(40)
plot(etopo_25, axes=FALSE, breaks=bks, 
     col=c(sea_cols, land_cols), type='continuous',  
     plg=list(ext=c(190, 200, -90, 90))
) 

## Raster Stacks ##
# use the geodata package to get some data with monthly data bands. 
# Download bioclim data: global maximum temperature at 10 arc minute resolution
tmax <- worldclim_global(var='tmax', res=10, path='data')
# The data has 12 layers, one for each month
print(tmax)
# access different layers using [[
# Extract  January and July data and the annual maximum by location.
tmax_jan <- tmax[[1]]
tmax_jul <- tmax[[7]]
tmax_max <- max(tmax)

# Plot those maps
par(mfrow=c(2,2), mar=c(2,2,1,1))
bks <- seq(-50, 50, length=101)
pal <- colorRampPalette(c('lightblue','grey', 'firebrick'))
cols <- pal(100)
plg <- list(ext=c(190, 200, -90, 90))

plot(tmax_jan, col=cols, breaks=bks, 
     main='January maximum temperature', type='continuous', plg=plg)
plot(tmax_jul, col=cols, breaks=bks, 
     main='July maximum temperature', type='continuous', plg=plg)
plot(tmax_max, col=cols, breaks=bks, 
     main='Annual maximum temperature', type='continuous', plg=plg)


#######################################
## Overlaying raster and vector data ##
#######################################
# use some data to build up a more complex map of chlorophyll concentrations in the Southern Ocean.

## Cropping data ##
# When only interested in a subset of the area covered by a GIS dataset. 
# Cropping the data to the area of interest can make plotting easier and can also make GIS operations a lot faster, particularly if the data is complex.
so_extent <- ext(-60, -20, -65, -45)

# The crop function for raster data...
so_topo <- crop(etopo_25, so_extent)

# ... and the st_crop function to reduce some higher resolution coastline data
ne_10 <- st_read('../data/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')
st_agr(ne_10) <- 'constant'
so_ne_10 <- st_crop(ne_10, so_extent)

# plotting Sourthern Ocean chlorophyII(叶绿素)
sea_pal <- colorRampPalette(c('grey30', 'grey50', 'grey70'))

# Plot the underlying sea bathymetry
plot(so_topo, col=sea_pal(100), asp=1, legend=FALSE)
contour(so_topo, levels=c(-2000, -4000, -6000), add=TRUE, col='grey80')

# Add the land
plot(st_geometry(so_ne_10), add=TRUE, col='khaki', border='grey40')

#############################################
## Spatial joins and raster data extraction##
#############################################

## Spatial joining ##
# Spatial join means merge data spatially, similar as merge data with sf object by matching values in columns

# mapping ‘mosquito outbreaks’ in Africa: we are actually going to use some random data, mostly to demonstrate the useful st_sample function. 
set.seed(1)
# extract Africa from the ne_110 data and keep the columns we want to use
africa <- subset(ne_110, CONTINENT=='Africa', select=c('ADMIN', 'POP_EST'))

# transform to the Robinson projection
africa <- st_transform(africa, crs='ESRI:54030')
# create a random sample of points
mosquito_points <- st_sample(africa, 1000)

# Create the plot
plot(st_geometry(africa), col='khaki')
plot(mosquito_points, col='firebrick', add=TRUE)
# Show the sampling sites
plot(st_geometry(so_data), add=TRUE, pch=4, cex=2, col='white', lwd=3)

# turn the mosquito_points object from a geometry column (sfc) into a full sf data frame to join the data
mosquito_points <- st_sf(mosquito_points)
mosquito_points <- st_join(mosquito_points, africa['ADMIN'])

plot(st_geometry(africa), col='khaki')

# Add points coloured by country
plot(mosquito_points['ADMIN'], add=TRUE)

# aggregate the points within countries
mosquito_points_agg <- aggregate(
  mosquito_points, 
  by=list(country=mosquito_points$ADMIN), FUN=length
)
names(mosquito_points_agg)[2] <-'n_outbreaks'
print(mosquito_points_agg)
# Merge the number of outbreaks back onto the sf data
africa <- st_join(africa, mosquito_points_agg)
africa$area <- as.numeric(st_area(africa))
print(africa)
# Plot the results
par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1, 0))
plot(n_outbreaks ~ POP_EST, data=africa, log='xy', 
     ylab='Number of outbreaks', xlab='Population size')
plot(n_outbreaks ~ area, data=africa, log='xy',
     ylab='Number of outbreaks', xlab='Area (m2)')


# Alien invasion -- produce the map countries at risk
# Load the data and convert to a sf object
alien_xy <- read.csv('../data/aliens.csv')
alien_xy <- st_as_sf(alien_xy, coords=c('long','lat'), crs=4326)

# Add country information and find the total number of aliens per country
alien_xy <- st_join(alien_xy, ne_110['ADMIN'])
aliens_by_country <- aggregate(n_aliens ~ ADMIN, data=alien_xy, FUN=sum)

# Add the alien counts into the country data 
ne_110 <- merge(ne_110, aliens_by_country, all.x=TRUE)
ne_110$people_per_alien <- with(ne_110,  POP_EST / n_aliens )

# Find which countries are in danger
ne_110$in_danger <- ne_110$people_per_alien < 1000

# Plot the danger map
plot(ne_110['in_danger'], pal=c('grey', 'red'), key.pos=4)


## Extracting data from Rasters ##
# extract data from a raster dataset in certain locations
# Examples include to know the exact altitude or surface temperature of sampling sites or average values within a polygon

# use a chunk of the full resolution ETOPO1 elevation data
uk_eire_etopo <- rast('../data/uk/etopo_uk.tif')

uk_eire_detail <- subset(ne_10, ADMIN %in% c('United Kingdom', "Ireland"))
uk_eire_detail_raster <- rasterize(uk_eire_detail, uk_eire_etopo)
uk_eire_elev <- mask(uk_eire_etopo, uk_eire_detail_raster)

par(mfrow=c(1,2), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(uk_eire_etopo, plg=list(ext=c(3,4, 50, 59)))
plot(uk_eire_elev, plg=list(ext=c(3,4, 50, 59)))
plot(st_geometry(uk_eire_detail), add=TRUE, border='grey')


## Raster cell statistics and locations ##
# The global function provides a way to find global summary statistics of the data in a raster. 
# We can also find out the locations of cells with particular characteristics using where.max of where.min. 
# Both of those functions return cell ID numbers, but the xyFromCell allows you to turn those ID numbers into coordinates.
uk_eire_elev >= 1195

global(uk_eire_elev, max, na.rm=TRUE)
global(uk_eire_elev, quantile, na.rm=TRUE)

# Which is the highest cell
where.max(uk_eire_elev)

# Which cells are above 1100m
high_points <- where.max(uk_eire_elev >= 1100, value=FALSE)
xyFromCell(uk_eire_elev, high_points[,2])

# Highlight highest point and areas below sea level
# Plot the locations of the maximum altitude and cells below sea level on the map. 
max_cell <- where.max(uk_eire_elev)
max_xy <- xyFromCell(uk_eire_elev, max_cell[2])
max_sfc<- st_sfc(st_point(max_xy), crs=4326)

bsl_cell <- where.max(uk_eire_elev < 0, values=FALSE)
bsl_xy <- xyFromCell(uk_eire_elev, bsl_cell[,2])
bsl_sfc <- st_sfc(st_multipoint(bsl_xy), crs=4326)

plot(uk_eire_elev)
plot(max_sfc, add=TRUE, pch=24, bg='red')
plot(bsl_sfc, add=TRUE, pch=25, bg='lightblue', cex=0.6)

## The extract function ##
# POINT: extract the values under the points.
# LINESTRING: extract the values under the linestring
# POLYGON: extract the values within the polygon

# Extracting raster values under points is really easy.
uk_eire_capitals$elev <- extract(uk_eire_elev, uk_eire_capitals, ID=FALSE)
print(uk_eire_capitals)

# the extract function for polygons returns a data frame of individual raster cell values within each polygon, along with an ID code showing the polygon ID:
etopo_by_country <- extract(uk_eire_elev, uk_eire_sf['name'])
head(etopo_by_country)

# do summary statistics across those values:
aggregate(etopo_uk ~ ID, data=etopo_by_country, FUN='mean', na.rm=TRUE)

# use the zonal function to specify a summary statistic that should be calculated within polygons. 
zones <- rasterize(st_transform(uk_eire_sf, 4326), uk_eire_elev, field='name')
etopo_by_country <- zonal(uk_eire_elev, zones, fun='mean', na.rm=TRUE)

print(etopo_by_country)

# One feature of GPX files is that they contain multiple layers: 
# essentially different GIS datasets within a single source. 
# The st_layers function allows us to see the names of those layers so we can load the one we want.
st_layers('../data/uk/National_Trails_Pennine_Way.gpx')
# load the data, showing off the ability to use SQL queries to load subsets of the data
pennine_way <- st_read('../data/uk/National_Trails_Pennine_Way.gpx',
                       query="select * from routes where name='Pennine Way'")

# Reproject the Penine Way
# reproject the vector data
pennine_way_BNG <- st_transform(pennine_way, crs=27700)
# create the target raster and project the elevation data into it.
bng_2km <- rast(xmin=-200000, xmax=700000, ymin=0, ymax=1000000, 
                res=2000, crs='EPSG:27700')
uk_eire_elev_BNG <- project(uk_eire_elev, bng_2km, method='cubic')

# Simplify the data
pennine_way_BNG_simple <- st_simplify(pennine_way_BNG,  dTolerance=100)

# Zoom in to the whole route and plot the data
par(mfrow=c(1,2), mar=c(1,1,1,1))

plot(uk_eire_elev_BNG, xlim=c(3e5, 5e5), ylim=c(3.8e5, 6.3e5),
     axes=FALSE, legend=FALSE)
plot(st_geometry(pennine_way_BNG), add=TRUE, col='black')
plot(st_geometry(pennine_way_BNG_simple), add=TRUE, col='darkred')

# Add a zoom box and use that to create a new plot
zoom <- ext(3.78e5, 3.84e5, 4.72e5, 4.80e5)
plot(zoom, add=TRUE, border='red')

# Zoomed in plot
plot(uk_eire_elev_BNG, ext=zoom, axes=FALSE, legend=FALSE)
plot(st_geometry(pennine_way_BNG), add=TRUE, col='black')
plot(st_geometry(pennine_way_BNG_simple), add=TRUE, col='darkred')

#  extract the elevations, cell IDs and the XY coordinates of cells falling under that route. 
# Extract the data
pennine_way_trans <- extract(uk_eire_elev_BNG, pennine_way_BNG_simple, xy=TRUE)
head(pennine_way_trans)
# Now we can use Pythagoras to find the distance along the transect
pennine_way_trans$dx <- c(0, diff(pennine_way_trans$x))
pennine_way_trans$dy <- c(0, diff(pennine_way_trans$y))
pennine_way_trans$distance_from_last <- with(pennine_way_trans, sqrt(dx^2 + dy^2))
pennine_way_trans$distance <- cumsum(pennine_way_trans$distance_from_last) / 1000

plot( etopo_uk ~ distance, data=pennine_way_trans, type='l', 
      ylab='Elevation (m)', xlab='Distance (km)')


###################
## Mini Projects ##
###################
## WGS84 coordinates of a transect through New Guinea ##
transect_long <- c(132.3, 135.2, 146.4, 149.3)
transect_lat <- c(-1, -3.9, -7.7, -9.8)
# Create a total annual precipitation transect for New Guinea #
# Get the precipitation data
ng_prec <- worldclim_tile(var='prec', res=0.5, lon=140, lat=-10, path='data')

# Reduce to the extent of New Guinea - crop early to avoid unnecessary processing!
ng_extent <- ext(130, 150, -10, 0)
ng_prec <- crop(ng_prec, ng_extent)

# Calculate annual precipitation
ng_annual_prec <- sum(ng_prec)

# Now reproject to UTM 54S. The code here is using reprojecting the extent of the
# raster data to get sensible values for the UTM 54S extent. We are then picking extent 
# values here that create a neat 1000m grid with sensible cell edges
ng_extent_poly <- st_as_sfc(st_bbox(ng_extent, crs=4326))
ng_extent_utm <- ext(-732000, 1506000, 8874000, 10000000)

# Create the raster and reproject the data
ng_template_utm <- rast(ng_extent_utm, res=1000, crs="+init=EPSG:32754")
ng_annual_prec_utm <- project(ng_annual_prec, ng_template_utm)

# Create and reproject the transect and then segmentize it to 1000m
transect <-  st_linestring(cbind(x=transect_long, y=transect_lat))
transect <- st_sfc(transect, crs=4326)
transect_utm <- st_transform(transect, crs=32754)
transect_utm <- st_segmentize(transect_utm, dfMaxLength=1000)

# Extract the transect data
transect_data <- extract(ng_annual_prec_utm, st_sf(transect_utm), xy=TRUE)

# Now we can use Pythagoras to find the distance along the transect
transect_data$dx <- c(0, diff(transect_data$x))
transect_data$dy <- c(0, diff(transect_data$y))
transect_data$distance_from_last <- with(transect_data, sqrt(dx^2 + dy^2))
transect_data$distance <- cumsum(transect_data$distance_from_last) / 1000

# Get the natural earth high resolution coastline.
ne_10_ng  <- st_crop(ne_10, ng_extent_poly)
ne_10_ng_utm <-  st_transform(ne_10_ng, crs=32754)

par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,1,0))
plot(ng_annual_prec_utm, plg=list(ext=c(1700000, 1800000, 8950000, 9950000)))

plot(st_geometry(ne_10_ng_utm), add=TRUE, col=NA, border='grey50')
plot(transect_utm, add=TRUE)

par(mar=c(3,3,1,1))
plot( sum ~ distance, data=transect_data, type='l', 
      ylab='Annual precipitation (mm)', xlab='Distance (km)')

## Fishing pressure in Fiji ##
# Researchers have identified 7 commonly used fishing sites around the island of Kadavu in Fiji. 
# The have also conducted surveys of the coastal villages known to use these sites and are trying to identify how many households are likely to use site. 
# We are going to use the simplifying assumption that each village will always use the closest site.

# Loading the data #
# Download the GADM data for Fiji, convert to sf and then extract Kadavu
fiji <- gadm(country='FJI', level=2, path='data/fiji')
fiji <- st_as_sf(fiji)
kadavu <- subset(fiji, NAME_2 == 'Kadavu')

# Load the villages and sites and convert to sf
villages <- readWorkbook('../data/fiji/FishingPressure.xlsx', 'Villages')
villages <- st_as_sf(villages, coords=c('long','lat'), crs=4326)
sites <- readWorkbook('../data/fiji/FishingPressure.xlsx', 'Field sites', startRow=3)
sites <- st_as_sf(sites, coords=c('Long','Lat'), crs=4326)

# Reproject the data UTM60S
kadavu <- st_transform(kadavu, 32760)
villages <- st_transform(villages, 32760)
sites <- st_transform(sites, 32760)


# Map to check everything look right.
plot(st_geometry(sites), axes=TRUE, col='blue', pch=4)
plot(st_geometry(villages), add=TRUE, col='red')
plot(st_geometry(kadavu), add=TRUE)


# Create the cost surface #
# Create a template raster covering the whole study area, at a given resolution
res <- 100
r <- rast(xmin=590000, xmax=670000, ymin=7870000, ymax=7940000, crs='EPSG:32760', res=res)

# Rasterize the island as a POLYGON to get cells that cannot be traversed
kadavu_poly <- rasterize(kadavu, r, field=1, background=0)

# Rasterize the island as a MULTILINESTRING to get the coastal 
# cells that _can_ be traversed
coast <- st_cast(kadavu, 'MULTILINESTRING')
kadavu_lines <- rasterize(coast, r, field=1, background=0)

# Combine those to give cells that are in the sea (kadavu_poly=0) or 
# on the coast (kadavu_lines=1)
sea_r <- (! kadavu_poly) | kadavu_lines

# Set the costs
sea_r[sea_r == 0] <- NA
sea_r[! is.na(sea_r)] <- 1

# Plot the map and then zoom in to show that the coastal cells can
# be travelled through
par(mfrow=c(1,2), mar=c(2,2,1,1))
plot(sea_r, col='lightblue')
zoom <- ext(599000, 602000, 7884000, 7887000)
plot(zoom, add=TRUE)

plot(sea_r, ext=zoom, col='lightblue')
plot(st_geometry(kadavu), add=TRUE)

# Finding launch points #
# Find the nearest points on the coast to each village
village_coast <- st_nearest_points(villages, coast)

# Extract the end point on the coast and convert from MULTIPOINT to POINT
launch_points <- st_line_sample(village_coast, sample=1)
launch_points <- st_cast(launch_points, 'POINT')

# Zoom in to a bay on Kadavu
par(mar=c(0,0,0,0))
plot(st_geometry(kadavu), xlim=c(616000, 618000), ylim=c(7889000, 7891000), col='khaki')
# Plot the villages, lines to the nearest coast and the launch points.
plot(st_geometry(villages), add=TRUE, col='firebrick', lwd=2)
plot(village_coast, add=TRUE, col='black')
plot(launch_points, add=TRUE, col='darkgreen', lwd=2)
# add the launch points in to our villages object
villages$launch_points <- launch_points
st_geometry(villages) <- 'launch_points'

# Find distance #
# how the calculation works - note the added costs of moving around the blocking cell into the bottom right corner.
r <- rast(xmin=0, ymin=0, xmax=50, ymax=50, res=10, crs='EPSG:32760')

# Set cell values:
values(r) <- 1  # Set all cells to be non-NA
r[3,3] <- 0     # This is a target cell
r[4,4] <- NA    # Set one NA cell

# Calculate and plot distances
d <- gridDistance(r)
plot(d, legend=NULL)
text(d, digits=1)

# Scaling that up to give an example for a single site:
# Make a copy of the sea map
dist <- sea_r

# Find the location of a site and make that the target
site_idx <- 49
village_cell <- cellFromXY(dist, st_coordinates(villages[site_idx,]))
dist[village_cell] <- 0

# Now we can calculate the cost distance for each launch point to each site...
costs <- gridDistance(dist)

plot(costs, plg=list(ext=c(672000, 674000, 7870000, 7940000)))
plot(st_geometry(villages[site_idx,]), add=TRUE, pch=4)
plot(st_geometry(sites), add=TRUE)

# And grab the costs at each fishing site
distances_to_site <- extract(costs, sites)
print(distances_to_site)

# and find the smallest distance
nearest_site <- which.min(distances_to_site$layer)

# Loop over sites #
# to wrap that process in a loop to find the nearest site for each village 
# Create fields to hold the nearest fishing site data
villages$nearest_site_index <- NA
villages$nearest_site_name <- NA

# Loop over the sites
for (site_idx in seq(nrow(villages))) {
  
  # Make a copy of the sea map
  dist <- sea_r
  
  # Find the location of a site and make that the target
  village_cell <- cellFromXY(dist, st_coordinates(villages[site_idx,]))
  dist[village_cell] <- 0
  
  # Now we can calculate the cost distance for each launch point to each site...
  costs <- gridDistance(dist)
  
  # And find the nearest site
  distances_to_site <- extract(costs, sites)
  nearest_site <- which.min(distances_to_site$layer)
  
  # Find the index and name of the lowest distance in each row
  villages$nearest_site_index[site_idx] <- nearest_site
  villages$nearest_site_name[site_idx] <- sites$Name[nearest_site]
  
}

# work out the fishing load for each site and map which villages prefer which site:
# Find the total number of buildings  per site and merge that data
# into the sites object
site_load <- aggregate(building_count ~ nearest_site_name, data=villages, FUN=sum)
sites_with_load <- merge(sites, site_load, by.x='Name', by.y='nearest_site_name', all.x=TRUE)

# Now build up a complex plot
par(mar=c(0,0,0,0))
plot(st_geometry(kadavu))

# add the villages, colouring by nearest site and showing the village 
# size using the symbol size (cex)
plot(villages['nearest_site_name'], add=TRUE, pch=20, cex=log10(villages$building_count))

# Add the sites
plot(st_geometry(sites_with_load), add=TRUE, col='red', pch=4, lwd=4)
print(sites_with_load)

################################
## Using ggplot to make maps ##
################################
library(ggplot2)
ggplot(ne_110) +
  geom_sf() +
  theme_bw()
# There are several ggplot extensions for sf that make it easier to colour and label your ggplot maps. 
# !!! Here is a bad example !!!:
europe <- st_crop(ne_110, ext(-10,40,35,75))
ggplot(europe) +
  geom_sf(aes(fill=GDP_MD)) +
  scale_fill_viridis_c() +
  theme_bw() + 
  geom_sf_text(aes(label = ADMIN), colour = "white")

# European life expectancy #
# Calculate the extent in the LAEA projection of the cropped data
europe_crop_laea <- st_transform(europe, 3035)

# Reproject all of the country data and _then_ crop to the previous extent
europe_laea <- st_transform(ne_110, 3035)
europe_laea <- st_crop(europe_laea, europe_crop_laea)

# Plot the two maps
p1 <- ggplot(europe_crop_laea) +
  geom_sf(aes(fill=log(GDP_MD))) +
  scale_fill_viridis_c() +
  theme_bw() + 
  theme(legend.position="bottom") +
  geom_sf_text(aes(label = ADM0_A3), colour = "grey20")

p2 <- ggplot(europe_laea) +
  geom_sf(aes(fill=log(GDP_MD))) +
  coord_sf(expand=FALSE) +
  scale_fill_viridis_c() +
  theme_bw() + 
  theme(legend.position="bottom") +
  geom_sf_text(aes(label = ADM0_A3), colour = "grey20")

library(gridExtra)
grid.arrange(p1, p2, ncol=2)

#####################
## Colour palettes ##
#####################
## Viridis
## Brewer
library(RColorBrewer)
display.brewer.all()
# The brewer packages has a neat way of showing colours that are colourblind-friendly.
display.brewer.all(colorblindFriendly = TRUE)
