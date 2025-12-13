# RingHTML Example 01: Basic HTML Parsing
# This example demonstrates the fundamental usage of the RingHTML parser.

load "html.ring"

# Sample HTML content for demonstration
cHTML = `
<html>
<head>
	<title>Basic HTML Parsing Example</title>
</head>
<body>
	<h1>Welcome to RingHTML</h1>
	<div class="content">
		<p>This is a paragraph with <strong>bold text</strong> and <a href="#">a link</a>.</p>
		<p>This is another paragraph.</p>
	</div>
</body>
</html>
`

? "=== RingHTML: Basic HTML Parsing Example ===" + nl

# Step 1: Parse the HTML document
# The HTML class constructor automatically parses the HTML string
doc = new HTML(cHTML)

if isnull(doc)
	? "Error: Failed to parse HTML document."
	return
ok

? "✅ HTML document parsed successfully!" + nl

# Step 2: Get the document body
body = doc.body()
if not isnull(body)
	? "✅ Body element found: " + body.tag()
	? "Body HTML content:"
	? body.html() + nl
else
	? "❌ Could not find body element."
	return
ok

? nl + "Done!"