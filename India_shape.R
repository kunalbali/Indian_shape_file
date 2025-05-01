# Load necessary libraries
library(sf)
library(dplyr)
library(ggplot2)

# Step 1: Read the existing India shapefile
# Replace with your actual file path
india <- st_read("/Users/kunalbali/Desktop/india_state/Export_Output.shp")

# Step 2: Check the structure of your data to find the state/region column
str(india)
# Look at column names to identify which contains state names
colnames(india)
# Optional: View the first few rows to see data structure
head(india)

# Step 3: Identify the Northwest states
# Adjust the column name and state names based on your data
# For example, if state names are in a column called "ST_NAME":
northwest_states <- c("Punjab", "Haryana", "Rajasthan", "Gujarat", "Delhi", "Chandigarh")

# Step 4: Filter to get only Northwest states
# Replace "ST_NAME" with your actual column name containing state names
northwest <- india %>%
  filter(ST_NAME %in% northwest_states)

# Step 5: Combine/dissolve all states into a single region
northwest_region <- northwest %>%
  st_union() %>%
  st_sf(geometry = ., region = "Northwest")

# Step 6: Write the Northwest region shapefile
st_write(northwest_region, "northwest_region.shp", append = FALSE)

# Step 7: Verify by reading it back and plotting
northwest_check <- st_read("northwest_region.shp")
ggplot() +
  geom_sf(data = india, fill = "white", color = "gray") +
  geom_sf(data = west_central, fill = "red", alpha = 0.5) +
  theme_minimal() +
  ggtitle("west_central of India")




# Load necessary libraries
library(sf)
library(dplyr)
library(ggplot2)

# Step 1: Read the existing India shapefile
india <- st_read("path/to/your/india_shapefile.shp")

# Step 2: Define states for each region
# Replace "ST_NAME" with your actual column name containing state names
# Adjust state names based on your data

northwest_states <- c("Punjab", "Haryana", "Rajasthan", "Gujarat", "Delhi", "Chandigarh")
northeast_states <- c("Assam", "Arunachal Pradesh", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Tripura", "Sikkim")
central_ne_states <- c("Bihar", "Jharkhand", "Uttar Pradesh",   "West Bengal", "Odisha")
west_central_states <- c("Maharashtra", "Goa","Madhya Pradesh","Chhattisgarh","Telangana")
peninsular_states <- c("Tamil Nadu", "Kerala", "Karnataka", "Andhra Pradesh")
hilly_states <- c("Jammu and Kashmir", "Ladakh", "Himachal Pradesh", "Uttarakhand")

# Step 3: Filter and process each region
northwest <- india %>% 
  filter(ST_NAME %in% northwest_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "Northwest")


northeast <- india %>% 
  filter(ST_NAME %in% northeast_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "Northeast")

central_ne <- india %>% 
  filter(ST_NAME %in% central_ne_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "Central_Northeast")

west_central <- india %>% 
  filter(ST_NAME %in% west_central_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "West_Central")

peninsular <- india %>% 
  filter(ST_NAME %in% peninsular_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "Peninsular")

hilly <- india %>% 
  filter(ST_NAME %in% hilly_states) %>%
  st_union() %>%
  st_sf(geometry = ., region = "Hilly_Regions")

# Step 4: Combine all regions
all_regions <- rbind(
  northwest,
  northeast,
  central_ne,
  west_central,
  peninsular,
  hilly
)

# Step 5: Write individual and combined shapefiles
st_write(northwest, "northwest_region.shp", append = FALSE)
st_write(northeast, "northeast_region.shp", append = FALSE)
st_write(central_ne, "central_northeast_region.shp", append = FALSE)
st_write(west_central, "west_central_region.shp", append = FALSE)
st_write(peninsular, "peninsular_region.shp", append = FALSE)
st_write(hilly, "hilly_regions.shp", append = FALSE)
st_write(all_regions, "india_regions.shp", append = FALSE)

# Step 6: Visualize
ggplot() +
  geom_sf(data = all_regions, aes(fill = region), alpha = 0.7) +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal() +
  ggtitle("Six Regions of India") +
  theme(legend.title = element_blank())
