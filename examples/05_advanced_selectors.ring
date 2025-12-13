# RingHTML Example 05: Advanced Selectors
# This example demonstrates complex CSS selectors and selector combinations.

load "html.ring"

# Sample HTML content with complex structure for advanced selector testing
cHTML = `
<html>
<head>
	<title>Advanced Selectors Example</title>
	<style>
		.featured { color: red; }
		.important { font-weight: bold; }
		.hidden { display: none; }
	</style>
</head>
<body>
	<div id="container">
		<h1>Advanced Selector Examples</h1>

		<!-- Direct child and adjacent selectors -->
		<div class="parent">
			<p>First child paragraph</p>
			<p>Second child paragraph</p>
			<span>Not a paragraph</span>
			<p>Third child paragraph</p>
		</div>

		<!-- nth-child selectors -->
		<ul class="numbered-list">
			<li>First item</li>
			<li>Second item</li>
			<li>Third item</li>
			<li>Fourth item</li>
			<li>Fifth item</li>
			<li>Sixth item</li>
		</ul>

		<!-- Attribute selectors -->
		<div class="attributes-test">
			<input type="text" name="username" id="user-input" required>
			<input type="email" name="email" required>
			<input type="password" name="password">
			<input type="submit" value="Submit">
		</div>

		<!-- Complex nested structures -->
		<div class="content">
			<article class="featured">
				<header>
					<h2>Featured Article</h2>
					<p class="meta">By <span class="author">John Doe</span></p>
				</header>
				<div class="body">
					<p>Content of featured article.</p>
				</div>
			</article>

			<article>
				<header>
					<h2>Regular Article</h2>
					<p class="meta">By <span class="author">Jane Smith</span></p>
				</header>
				<div class="body">
					<p>Content of regular article.</p>
				</div>
			</article>
		</div>

		<!-- Multiple classes and pseudo-selectors -->
		<div class="items">
			<div class="item featured important">Item 1</div>
			<div class="item important">Item 2</div>
			<div class="item featured">Item 3</div>
			<div class="item">Item 4</div>
			<div class="item featured important hidden">Item 5</div>
		</div>

		<!-- Form elements -->
		<form class="contact-form">
			<fieldset>
				<legend>Personal Information</legend>
				<label for="name">Name:</label>
				<input type="text" id="name" name="name">

				<label for="email">Email:</label>
				<input type="email" id="email" name="email">

				<label for="country">Country:</label>
				<select id="country" name="country">
					<option value="">Select Country</option>
					<option value="us">United States</option>
					<option value="ca">Canada</option>
					<option value="uk">United Kingdom</option>
				</select>
			</fieldset>
		</form>
	</div>
</body>
</html>
`

? "=== RingHTML: Advanced Selectors Example ===" + nl

# Parse the HTML document
doc = new HTML(cHTML)

? "✅ HTML document parsed successfully!" + nl

# Example 1: Child and adjacent selectors
? "=== 1. Child and Adjacent Selectors ==="

aParentDivs = doc.find(".parent")
if len(aParentDivs) > 0
	parent = aParentDivs[1]

	# Direct children
	aDirectChildren = parent.find("p")
	? "Direct paragraph children: " + len(aDirectChildren)

	# All descendants
	aAllParagraphs = parent.find("* p")
	? "All paragraph descendants: " + len(aAllParagraphs)
	see nl
ok

# Example 2: nth-child selectors
? "=== 2. nth-child Selectors ==="

aListItems = doc.find(".numbered-list li")
? "Total list items: " + len(aListItems)

# First child
aFirstItems = doc.find(".numbered-list li:first-child")
? "First items: " + len(aFirstItems)
if len(aFirstItems) > 0
	? "First item text: " + aFirstItems[1].text()
ok

# Last child
aLastItems = doc.find(".numbered-list li:last-child")
? "Last items: " + len(aLastItems)
if len(aLastItems) > 0
	? "Last item text: " + aLastItems[1].text()
ok

# Odd items
aOddItems = doc.find(".numbered-list li:nth-child(odd)")
? "Odd items: " + len(aOddItems)

# Even items
aEvenItems = doc.find(".numbered-list li:nth-child(even)")
? "Even items: " + len(aEvenItems)
see nl

# Example 3: Attribute selectors
? "=== 3. Attribute Selectors ==="

# Elements with specific attribute
aRequiredInputs = doc.find("input[required]")
? "Required inputs: " + len(aRequiredInputs)

# Elements with type attribute
aTextInputs = doc.find("input[type='text']")
? "Text inputs: " + len(aTextInputs)

# Elements with name attribute
aNamedInputs = doc.find("input[name]")
? "Inputs with name attribute: " + len(aNamedInputs)

# Elements with specific name
aEmailInputs = doc.find("input[name='email']")
? "Email inputs: " + len(aEmailInputs)
for i = 1 to len(aEmailInputs)
	id = aEmailInputs[i].attr("id")
	if id = NULL
		? "  Email input " + i + " ID: (none)"
	else
		? "  Email input " + i + " ID: " + id
	ok
next
see nl

# Example 4: Complex selector combinations
? "=== 4. Complex Selector Combinations ==="

# Featured articles
aFeaturedArticles = doc.find("article.featured")
? "Featured articles: " + len(aFeaturedArticles)

# Authors of featured articles
aFeaturedAuthors = doc.find("article.featured .author")
? "Authors in featured articles: " + len(aFeaturedAuthors)
for i = 1 to len(aFeaturedAuthors)
	? "  Featured author " + i + ": " + aFeaturedAuthors[i].text()
next

# Important items that are also featured
aImportantFeatured = doc.find(".item.important.featured")
? "Items that are both important and featured: " + len(aImportantFeatured)
for i = 1 to len(aImportantFeatured)
	? "  Important+Featured item " + i + ": " + aImportantFeatured[i].text()
next
see nl

# Example 5: Form-specific selectors
? "=== 5. Form-Specific Selectors ==="

# All form controls
aFormControls = doc.find("input, select, textarea")
? "All form controls: " + len(aFormControls)

# Labels associated with inputs
aLabels = doc.find("label")
? "Labels: " + len(aLabels)

# Fieldsets and legends
aFieldsets = doc.find("fieldset")
? "Fieldsets: " + len(aFieldsets)

aLegends = doc.find("legend")
? "Legends: " + len(aLegends)
see nl

# Example 6: Hierarchical selectors
? "=== 6. Hierarchical Selectors ==="

# Paragraphs that are direct children of divs
aDirectPara = doc.find("div > p")
? "Direct paragraph children of divs: " + len(aDirectPara)

# Spans that are descendants of headers
aHeaderSpans = doc.find("header span")
? "Spans in headers: " + len(aHeaderSpans)

# Authors that are children of meta paragraphs
aMetaAuthors = doc.find(".meta .author")
? "Authors in meta sections: " + len(aMetaAuthors)
see nl

# Example 7: Combining selectors with navigation
? "=== 7. Combining Selectors with Navigation ==="

# Get all articles and then find their authors
aArticles = doc.find("article")
? "Article analysis:"
for i = 1 to len(aArticles)
	article = aArticles[i]

	# Get title
	aTitles = article.find("h2")
	if len(aTitles) > 0
		title = aTitles[1].text()
	else
		title = "No title"
	ok

	# Get author
	aAuthors = article.find(".author")
	if len(aAuthors) > 0
		author = aAuthors[1].text()
	else
		author = "Unknown author"
	ok

	# Check if featured
	isFeatured = len(article.find(".featured")) > 0

	? "  Article " + i + ":"
	? "    Title: " + title
	? "    Author: " + author
	if isFeatured
		? "    Featured: Yes"
	else
		? "    Featured: No"
	ok
next
see nl

? nl + "Done!"