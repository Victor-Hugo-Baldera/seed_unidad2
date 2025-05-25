
source("https://inkaverse.com/setup.r")

# Cargar librerías necesarias
library(googlesheets4)
library(dplyr)
library(huito)


# Cargar datos

url <- "https://docs.google.com/spreadsheets/d/1Eg67TqQINnAfa29ncqlPCAN7umUbyrkBbNOjd1us85Q/edit?gid=1454035531#gid=1454035531"

gs <- as_sheets_id(url)
fb <- range_read(gs, sheet = "fb")

fb


# Crear etiqueta


font <- c("Permanent Marker", "Tillana", "Courgette")

huito_fonts(font)

label <- fb %>% 
  mutate(color = case_when(
    factor1 %in% "Control" ~ "blue",
    factor1 %in% "Mecánico.(.Bisturí)" ~ "red",
    factor1 %in% "Mecánico.(.Lija)" ~ "orange",
    factor1 %in% "Agua.Hervida" ~ "purple"
  )) %>% 
  label_layout(size = c(5, 9), border_color = "forestgreen"
               , border_width = 1.5) %>%
  include_image(value = "https://huito.inkaverse.com/img/scale.pdf"
                , size = c(4.8, 1)
                , position = c(2.5, 7.2)) %>% 
  include_image(value = "pts.png",
                size = c(2.5, 2.5),
                position = c(0.9, 1.1)) %>%
  include_image(value = "logo_fica.jpg",
                size = c(1.3, 1.3),
                position = c(4, 1.2)) %>% 
  include_barcode(value = "barcode",
                  size = c(4.7, 4.7),
                  position = c(2.5, 4.25)) %>%
  include_image(value = "https://www.untrm.edu.pe/assets/images/untrmazul.png"
                , size = c(3, 3)
                , position = c(1.7, 8.3)) %>% 
  include_text(value = "factor1"
               , position = c(2.6, 1.2)
               , size = 14
               , color = "color" # dynamic column
               , font[2]) %>% 
  include_text(value = "plots",
               position = c(4.4, 8.3),
               size = 16,
               color = "black",
               font[1])


label %>% 
  label_print(mode = "preview")


label %>% 
  label_print(mode = "complete", filename = "etiquetas", nlabels = 20)


