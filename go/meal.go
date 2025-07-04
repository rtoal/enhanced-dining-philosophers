// Each meal is an entree with an optional soup and an optional dessert. While
// it is possible to represent the meal options with pointers, it is simpler
// to just use a string for the choice of no soup and no dessert.

package main

import "math/rand"

var entree map[string]float64 = map[string]float64{
	"Paella":              13.25,
	"Wu Hsiang Chi":       10.00,
	"Bogrács Gulyás":      11.25,
	"Spanokopita":         6.50,
	"Moui Nagden":         12.95,
	"Sambal Goreng Udang": 14.95,
}

var soup map[string]float64 = map[string]float64{
	"Albóndigas": 3.00,
	"No soup":    0.00,
}

var dessert map[string]float64 = map[string]float64{
	"Berog":      3.50,
	"No dessert": 0.00,
}

type Meal struct {
	entree  string
	dessert string
	soup    string
}

func randomMapItem(m map[string]float64) string {
	keys := make([]string, 0, len(m))
	for key := range m {
		keys = append(keys, key)
	}
	return keys[rand.Intn(len(keys))]
}

func RandomMeal() Meal {
	return Meal{
		entree:  randomMapItem(entree),
		dessert: randomMapItem(dessert),
		soup:    randomMapItem(soup),
	}
}

func (m Meal) String() string {
	text := m.entree
	if m.soup != "No soup" {
		text += " with " + m.soup
	}
	if m.dessert != "No dessert" {
		text += " then " + m.dessert
	}
	return text
}

func (m Meal) Price() float64 {
	return entree[m.entree] + soup[m.soup] + dessert[m.dessert]
}
