# RingHTML Example 04: DOM Navigation
# This example demonstrates how to navigate the DOM tree using parent, sibling, and children methods.

load "html.ring"

# Sample HTML content with nested structure for navigation testing
cHTML = `
<html>
<head>
	<title>DOM Navigation Example</title>
</head>
<body>
	<header>
		<h1>Website Title</h1>
		<nav>
			<ul class="main-nav">
				<li><a href="#home">Home</a></li>
				<li><a href="#about">About</a></li>
				<li><a href="#services">Services</a></li>
				<li><a href="#contact">Contact</a></li>
			</ul>
		</nav>
	</header>

	<main>
		<section class="hero">
			<h2>Welcome Section</h2>
			<p>Hero content here.</p>
		</section>

		<section class="content">
			<article>
				<header>
					<h3>Article 1</h3>
					<p class="meta">By Author 1</p>
				</header>
				<div class="article-content">
					<p>First paragraph of article 1.</p>
					<p>Second paragraph of article 1.</p>
					<p>Third paragraph of article 1.</p>
				</div>
			</article>

			<article>
				<header>
					<h3>Article 2</h3>
					<p class="meta">By Author 2</p>
				</header>
				<div class="article-content">
					<p>First paragraph of article 2.</p>
					<p>Second paragraph of article 2.</p>
				</div>
			</article>
		</section>

		<aside class="sidebar">
			<div class="widget">
				<h4>Categories</h4>
				<ul>
					<li><a href="#cat1">Category 1</a></li>
					<li><a href="#cat2">Category 2</a></li>
				</ul>
			</div>
		</aside>
	</main>

	<footer>
		<p>&copy; 2024 Example Company</p>
	</footer>
</body>
</html>
`

? "=== RingHTML: DOM Navigation Example ===" + nl

# Parse the HTML document
doc = new HTML(cHTML)

? "✅ HTML document parsed successfully!" + nl

# Example 1: Parent navigation
? "=== 1. Parent Navigation ==="

# Find a navigation link and navigate up
aNavLinks = doc.find("nav a")
if len(aNavLinks) > 0
	firstLink = aNavLinks[1]
	? "Starting element: " + firstLink.text() + " (" + firstLink.tag() + ")"

	# Navigate up to find parents
	pParent = firstLink.parent()
	if not isnull(pParent)
		? "Parent: " + pParent.tag()

		pGrandParent = pParent.parent()
		if not isnull(pGrandParent)
			? "Grandparent: " + pGrandParent.tag()

			pGreatGrandParent = pGrandParent.parent()
			if not isnull(pGreatGrandParent)
				? "Great-grandparent: " + pGreatGrandParent.tag()
			ok
		ok
	ok
	see nl
ok

# Example 2: Children navigation
? "=== 2. Children Navigation ==="

# Get the main navigation and explore its children
aNavs = doc.find("nav")
if len(aNavs) > 0
	nav = aNavs[1]
	? "Navigation element children:"

	aChildren = nav.children()
	for i = 1 to len(aChildren)
		child = aChildren[i]
		see "  " + i + ". " + child.tag()
		if child.has_attr("class")
			see " (class: " + child.attr("class") + ")"
		ok
		see nl
	next
	see nl
ok

# Example 3: Sibling navigation
? "=== 3. Sibling Navigation ==="

# Find articles and navigate between them
aArticles = doc.find("article")
if len(aArticles) >= 2
	firstArticle = aArticles[1]
	secondArticle = aArticles[2]

	? "First article title: " + firstArticle.find("h3")[1].text()
	? "Second article title: " + secondArticle.find("h3")[1].text() + nl

	# Navigate from first to second article
	pNextSibling = firstArticle.next_sibling()
	if not isnull(pNextSibling)
		? "Next sibling of first article: " + pNextSibling.tag()
		if pNextSibling.has_attr("class")
			? "Next sibling class: " + pNextSibling.attr("class")
		ok
	else
		? "First article has no next sibling"
	ok

	# Navigate from second back to first article
	pPrevSibling = secondArticle.prev_sibling()
	if not isnull(pPrevSibling)
		? "Previous sibling of second article: " + pPrevSibling.tag()
		if pPrevSibling.has_attr("class")
			? "Previous sibling class: " + pPrevSibling.attr("class")
		ok
	else
		? "Second article has no previous sibling"
	ok
	see nl
ok

# Example 4: Complex navigation patterns
? "=== 4. Complex Navigation Patterns ==="

# Navigate from a paragraph to its article container
aParagraphs = doc.find("article p")
if len(aParagraphs) > 0
	firstPara = aParagraphs[1]
	? "Starting from paragraph: " + firstPara.text()

	# Navigate up to article
	pArticle = firstPara.parent()
	while not isnull(pArticle) and pArticle.tag() != "ARTICLE"
		pArticle = pArticle.parent()
	end

	if not isnull(pArticle)
		? "Found containing article: " + pArticle.find("h3")[1].text()

		# Get all paragraphs in this article
		aArticleParas = pArticle.find("p")
		? "Article contains " + len(aArticleParas) + " paragraphs"
	ok
	see nl
ok

# Example 5: Navigation with content extraction
? "=== 5. Navigation with Content Extraction ==="

# Extract all article metadata using navigation
aArticles = doc.find("article")
? "Article metadata extraction:"
for i = 1 to len(aArticles)
	article = aArticles[i]

	# Get article title
	aTitles = article.find("h3")
	title = ""
	if len(aTitles) > 0
		title = aTitles[1].text()
	ok

	# Get article author
	aMetas = article.find(".meta")
	author = ""
	if len(aMetas) > 0
		author = aMetas[1].text()
	ok

	# Get paragraph count
	paraCount = len(article.find("p"))

	? "  Article " + i + ":"
	? "    Title: " + title
	? "    Author: " + author
	? "    Paragraphs: " + paraCount
next
see nl

? nl + "Done!"