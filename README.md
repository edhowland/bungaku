# Bungaku

Ruby Markdown Templating Engine

## Version

0.2.3

## Abstract

Bungaku (Japanese for Literature) is a Ruby library (and gem) for templating
engine for creating Markdown and other formats, such as HTML and PDF.
It follows the convention of an 'Outside-In' style of templating. Many other
template engines are 'Inside-Out'. E.g. ERb is an example of one type.
On the outside, you have some other file format, such as HTML or Markdown. Within this content,
there is embedded ruby. It generally follows the tag structure of the
content it embedded in. E.g. '<% a.ruby.method %>'.


### Outside-In Engines

Bungaku takes a differ approach to templating. It is along the style of Builder:
XmlMarkup::Builder).
Bungaku files are just regular Ruby programs. The content of a Bungaku file
contains the Bungaku DSL in the stryle of Rake. There are methods for generating
most of the Markdown elements such as H1..H6, Links, Code, Bullets, Numbered lists, etc.
In addition, it uses a Rake-like 'import' method to pull in other
content.


Let's look at Bungaku code in action

```
h1 'A Header at level 1'

para <<-EOP
This a paragraph with embedded [bold bold style].
EOP

link 'Google Homepage', 'http://www.google.com'

code <<-EOC
$ date
EOC

bullets 'Bullet 1', 'Bullet 2', 'Bullet 3'

```

## Ruby Syntax

Since Bungaku files are just Ruby, they can contain 
other Ruby stuff as well. They can be syntax checked like regular Ruby .rb files.
This is useful for programatically generating a lot of content
One such use is dynamically generating links to other parts
of the documentation, in a User's  Guide.


