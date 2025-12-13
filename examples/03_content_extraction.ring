# RingHTML Example 03: Content Extraction
# This example demonstrates how to extract text and HTML content from elements.

load "html.ring"

# Sample HTML content with various content types
cHTML = `
<html>
<head>
	<title>Content Extraction Example</title>
	<meta name="description" content="Learn how to extract content from HTML">
</head>
<body>
	<article class="blog-post">
		<header>
			<h1>Mastering Content Extraction</h1>
			<div class="meta">
				<span class="author">John Doe</span>
				<time datetime="2024-01-15">January 15, 2024</time>
			</div>
		</header>

		<div class="content">
			<p>This is the <strong>first paragraph</strong> with some <em>emphasized text</em> and a <a href="#link1">link</a>.</p>

			<p>This is the <strong>second paragraph</strong>. It contains multiple sentences and demonstrates how text content is extracted from complex HTML structures.</p>

			<blockquote>
				<p>"This is a blockquote with nested content that should be extracted properly."</p>
				<cite>— Famous Author</cite>
			</blockquote>

			<h2>Lists and Nested Content</h2>
			<ul>
				<li>Item 1 with <strong>bold text</strong></li>
				<li>Item 2 with <a href="#item2">a link</a></li>
				<li>Item 3 with <em>italic text</em></li>
			</ul>

			<h2>Code Example</h2>
			<pre><code>function hello() {
	console.log("Hello, World!");
}</code></pre>
		</div>
	</article>
</body>
</html>
`

? "=== RingHTML: Content Extraction Example ===" + nl

# Parse the HTML document
doc = new HTML(cHTML)

? "✅ HTML document parsed successfully!" + nl

# Example 1: Extract text content
? "=== 1. Text Content Extraction ==="

# Get the main article
aArticles = doc.find("article")
if len(aArticles) > 0
	article = aArticles[1]

	? "Article title (text only): " + article.find("h1")[1].text()
	? "Author (text only): " + article.find(".author")[1].text()
	? "Publication date (text only): " + article.find("time")[1].text() + nl

	# Extract all paragraph text
	aParagraphs = article.find("p")
	? "All paragraph texts:"
	for i = 1 to len(aParagraphs)
		? "  " + i + ". " + aParagraphs[i].text()
	next
	see nl
ok

# Example 2: Extract HTML content
? "=== 2. HTML Content Extraction ==="

if len(aArticles) > 0
	article = aArticles[1]

	? "Article header HTML:"
	? article.find("header")[1].html() + nl

	? "First paragraph HTML:"
	? aParagraphs[1].html() + nl

	? "Code block HTML:"
	aCodeBlocks = article.find("pre")
	if len(aCodeBlocks) > 0
		? aCodeBlocks[1].html() + nl
	ok
ok

# Example 3: Extract attribute values
? "=== 3. Attribute Value Extraction ==="

# Get meta description
aMetaTags = doc.find("meta")
for i = 1 to len(aMetaTags)
	meta = aMetaTags[i]
	if meta.has_attr("name") and meta.attr("name") = "description"
		? "Meta description: " + meta.attr("content")
		break
	ok
next

# Get all links and their hrefs
aLinks = doc.find("a")
? "All links and their URLs:"
for i = 1 to len(aLinks)
	link = aLinks[i]
	? "  " + link.text() + " -> " + link.attr("href")
next
see nl

# Example 4: Extract structured data
? "=== 4. Structured Data Extraction ==="

if len(aArticles) > 0
	article = aArticles[1]

	# Extract article metadata
	? "Article Metadata:"
	? "  Title: " + article.find("h1")[1].text()
	? "  Author: " + article.find(".author")[1].text()
	? "  Date: " + article.find("time")[1].text()
	if len(article.find("pre")) > 0
		? "  Has code example: Yes"
	else
		? "  Has code example: No"
	ok
	? "  Number of paragraphs: " + len(article.find("p"))
	? "  Number of links: " + len(article.find("a"))
	see nl
ok

# Example 5: Content cleaning and formatting
? "=== 5. Content Cleaning and Formatting ==="

if len(aArticles) > 0
	article = aArticles[1]

	# Clean text content
	aParagraphs = article.find("p")
	? "Clean paragraph texts:"
	for i = 1 to len(aParagraphs)
		text = aParagraphs[i].text()
		text = trim(text)
		? "  " + i + ". " + text
	next
	see nl
ok

? nl + "Done!"