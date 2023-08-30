package main

import (
	"html/template"
	"os"
	"path/filepath"
	"snippetbox/internal/models"
	"strings"
	"time"
)

type templateData struct {
	Snippet         *models.Snippet
	Snippets        []*models.Snippet
	CurrentYear     int
	Form            any
	Flash           string
	IsAuthenticated bool
	CSRFToken       string
	User            *models.User
}

func humanDate(t time.Time) string {
	if t.IsZero() {
		return ""
	}
	return t.UTC().Format("02 Jan 2006 at 15:04")
}

var functions = template.FuncMap{
	"humanDate": humanDate,
}

func newTemplateCache() (map[string]*template.Template, error) {
	cache := map[string]*template.Template{}

	cwd, err := os.Getwd()
	if err != nil {
		return nil, err
	}

	// Needed when testing
	if !strings.HasSuffix(cwd, "/cmd/web") {
		cwd += "/cmd/web"
	}

	pages, err := filepath.Glob(filepath.Join(cwd, "/../../ui/html/pages/*.gohtml"))
	if err != nil {
		return nil, err
	}

	for _, page := range pages {
		name := filepath.Base(page)

		ts, err := template.New(name).Funcs(functions).ParseFiles(filepath.Join(cwd, "/../../ui/html/base.gohtml"))
		if err != nil {
			return nil, err
		}

		ts, err = ts.ParseGlob(filepath.Join(cwd, "/../../ui/html/partials/*.gohtml"))
		if err != nil {
			return nil, err
		}

		ts, err = ts.ParseFiles(page)
		if err != nil {
			return nil, err
		}

		cache[name] = ts
	}

	return cache, nil
}
