# RingHTML Example 02: CSS Selectors
# This example demonstrates how to use CSS selectors to find elements in HTML documents.

load "html.ring"

# Sample HTML content with various elements for selector testing
cHTML = `
<html>
<head>
	<title>CSS Selectors Example</title>
</head>
<body>
	<header>
		<h1 id="main-title" class="title">Welcome to CSS Selectors</h1>
		<nav class="navigation">
			<a href="#home">Home</a>
			<a href="#about">About</a>
			<a href="#contact">Contact</a>
		</nav>
	</header>

	<main>
		<div class="content">
			<h2>Articles</h2>
			<article class="post featured">
				<h3>First Article</h3>
				<p>This is the first article content.</p>
			</article>
			<article class="post">
				<h3>Second Article</h3>
				<p>This is the second article content.</p>
			</article>
		</div>

		<aside class="sidebar">
			<div class="widget">
				<h4>Categories</h4>
				<ul>
					<li><a href="#tech">Technology</a></li>
					<li><a href="#science">Science</a></li>
					<li><a href="#art">Art</a></li>
				</ul>
			</div>
		</aside>
	</main>
</body>
</html>
`

? "=== RingHTML: CSS Selectors Example ===" + nl

# Parse the HTML document
doc = new HTML(cHTML)

? "✅ HTML document parsed successfully!" + nl

# Example 1: Find by tag name
? "=== 1. Tag Selectors ==="
aHeadings = doc.find("h1")
? "Found " + len(aHeadings) + " h1 elements"
if len(aHeadings) > 0
	? "First h1 text: " + aHeadings[1].text()
ok
see nl

# Example 2: Find by ID
? "=== 2. ID Selectors ==="
aMainTitle = doc.find("#main-title")
? "Found " + len(aMainTitle) + " element with id 'main-title'"
if len(aMainTitle) > 0
	? "Title text: " + aMainTitle[1].text()
ok
see nl

# Example 3: Find by class
? "=== 3. Class Selectors ==="
aPosts = doc.find(".post")
? "Found " + len(aPosts) + " elements with class 'post'"
for i = 1 to len(aPosts)
	post = aPosts[i]
	? "Post " + i + " title: " + post.find("h3")[1].text()
next
see nl

# Example 4: Multiple selectors
? "=== 4. Multiple Selectors ==="
aLinks = doc.find("a")
? "Found " + len(aLinks) + " total links"

aNavLinks = doc.find("nav a")
? "Found " + len(aNavLinks) + " navigation links"
see nl

# Example 5: Complex selectors
? "=== 5. Complex Selectors ==="
aFeaturedPosts = doc.find(".featured")
? "Found " + len(aFeaturedPosts) + " featured posts"

aSidebarHeadings = doc.find(".sidebar h4")
? "Found " + len(aSidebarHeadings) + " h4 elements in sidebar"
if len(aSidebarHeadings) > 0
	? "Sidebar heading text: " + aSidebarHeadings[1].text()
ok
see nl

# Example 6: Selector combinations
? "=== 6. Selector Combinations ==="
aListItems = doc.find("li a")
? "Found " + len(aListItems) + " links inside list items"

aArticlesInMain = doc.find("main article")
? "Found " + len(aArticlesInMain) + " articles in main content"
see nl

? nl + "Done!"