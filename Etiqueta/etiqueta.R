
source("https://inkaverse.com/setup.r")

# Cargar librerías necesarias
library(googlesheets4)
library(dplyr)
library(huito)


# Cargar datos

url <- "https://docs.google.com/spreadsheets/d/1Eg67TqQINnAfa29ncqlPCAN7umUbyrkBbNOjd1us85Q/edit?gid=1454035531#gid=1454035531"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

View(fb)


# Crear etiqueta


font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)

label <- fb %>% 
  mutate(color = case_when(
    factor1 %in% "Control" ~ "blue",
    factor1 %in% "Mecánico.(.Bisturí)" ~ "red",
    factor1 %in% "Mecánico.(.Lija)" ~ "orange",
    factor1 %in% "Agua.Hervida" ~ "purple",
    TRUE ~ "black"
  ),
  barcode = paste(factor1, plots, sep = "_"),
  barcode = gsub(" ", "-", barcode),
  treat_label = paste0("T", ntreat)) %>%
  
  
  label_layout(size = c(5, 8.5), border_color = "forestgreen"
               , border_width = 1.5) %>%
  include_image(value = "https://huito.inkaverse.com/img/scale.pdf"
                , size = c(4.8, 1)
                , position = c(2.5, 6.85)) %>% 
  include_image(value = "pts.png",
                size = c(2.3, 2.3),
                position = c(0.8, 0.8)) %>%
  include_image(value = "logo_fica.jpg",
                size = c(1.3, 1.3),
                position = c(4.2, 0.85)) %>% 
  include_barcode(value = "barcode",
                  size = c(4.3, 4.24),
                  position = c(2.5, 4.25)) %>%
  include_image(value = "https://www.untrm.edu.pe/assets/images/untrmazul.png"
                , size = c(3, 3)
                , position = c(1.8, 7.9)) %>% 
  include_text(value = "factor1"
               , position = c(2.6, 1.8)
               , size = 13
               , color = "color" # dynamic column
               , font[2]) %>% 
  include_text(value = "plots",
               position = c(4.4, 7.9),
               size = 16,
               color = "black",
               font[1]) %>% 
  include_text(
    value = "GRUPO 5",
    , position = c(2.5, 1.1)
    ,size = 13.5,
    color = "brown",
    font = font[2]
  ) %>% 
  include_text(value = "treat_label",
               position = c(2.45, 0.5), 
               size = 16, 
               color = "brown", 
               font = font[1])


label %>% 
  label_print(mode = "preview")


label %>% 
  label_print(mode = "complete", filename = "etiquetas", nlabels = 20)


