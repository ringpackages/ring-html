# RingHTML Example 08: DOM Manipulation
# This example demonstrates creating and manipulating HTML documents using the RingHTML library.

load "html.ring"

? copy("=", 70)
? "DOM Manipulation Example - Building HTML from Scratch"
? copy("=", 70)

# Create an empty document
doc = new HTML("<html></html>")

# Access document structure
rootNode = doc.root()
? nl + "1. Document Root: " + rootNode.tag()

# Get or create head element
headNode = doc.head()
if isNull(headNode)
	headNode = doc.createNode("head")
	rootNode.appendChild(headNode)
ok
? "2. Head element: " + headNode.tag()

# Create meta tags
metaCharset = doc.createNode("meta")
metaCharset.setAttribute("charset", "UTF-8")
headNode.appendChild(metaCharset)

metaViewport = doc.createNode("meta")
metaViewport.setAttribute("name", "viewport")
metaViewport.setAttribute("content", "width=device-width, initial-scale=1.0")
headNode.appendChild(metaViewport)

# Create title
titleNode = doc.createNode("title")
titleNode.setInnerText("DOM Manipulation Demo")
headNode.appendChild(titleNode)

? "3. Created head elements with meta tags and title"

# Get or create body
bodyNode = doc.body()
if isNull(bodyNode)
	bodyNode = doc.createNode("body")
	rootNode.appendChild(bodyNode)
ok

# Create a container div
container = doc.createNode("div")
container.setAttribute("id", "container")
container.setAttribute("class", "main-content")
bodyNode.appendChild(container)

# Create heading
h1 = doc.createNode("h1")
h1.setInnerText("Welcome to Ring HTML DOM Manipulation")
container.appendChild(h1)

# Create paragraph with mixed content
para = doc.createNode("p")
para.setAttribute("class", "intro")
para.setInnerHTML("This is a <strong>powerful</strong> HTML parser with <em>full DOM manipulation</em> capabilities!")
container.appendChild(para)

# Create a list
ul = doc.createNode("ul")
ul.setAttribute("class", "feature-list")

for i = 1 to 5
	li = doc.createNode("li")
	li.setInnerText("Feature #" + i)
	ul.appendChild(li)
next

container.appendChild(ul)

? nl + "4. Built complete HTML structure"
? copy("=", 70)
? "Generated HTML:"
? copy("=", 70)
? rootNode.html()

# =====================================================================
# Modifying existing HTML
# =====================================================================
? copy("=", 70)
? "Modifying Existing HTML"
? copy("=", 70)

html = '
<html>
	<body>
		<div id="content">
			<h2>Original Title</h2>
			<p class="old">This is old content</p>
			<ul id="items">
				<li>Item 1</li>
				<li>Item 2</li>
				<li>Item 3</li>
			</ul>
		</div>
	</body>
</html>
'

doc2 = new HTML(html)

# Find and modify the heading
headings = doc2.find("h2")
if len(headings) > 0
	headings[1].setInnerText("Modified Title!")
	headings[1].setAttribute("class", "highlight")
	? nl + "5. Modified heading text and added class attribute"
ok

# Find and update paragraph
paragraphs = doc2.find("p.old")
if len(paragraphs) > 0
	paragraphs[1].setInnerHTML("<strong>This is NEW content!</strong>")
	paragraphs[1].removeAttribute("class")
	paragraphs[1].setAttribute("class", "new")
	? "6. Updated paragraph content and class"
ok

# Add new list item
listItems = doc2.find("#items")
if len(listItems) > 0
	newLi = doc2.createNode("li")
	newLi.setInnerText("Item 4 (NEW!)")
	newLi.setAttribute("class", "new-item")
	listItems[1].appendChild(newLi)
	? "7. Added new list item"
ok

# Insert element before existing one
firstLi = doc2.find("#items li")[1]
if not isNull(firstLi)
	newFirst = doc2.createNode("li")
	newFirst.setInnerText("Item 0 (Inserted Before)")
	newFirst.setAttribute("style", "font-weight: bold")
	firstLi.insertBefore(newFirst)
	? "8. Inserted item before first li"
ok

# Insert element after existing one
allLi = doc2.find("#items li")
if len(allLi) > 0
	lastLi = allLi[len(allLi)]  # Get last item from list
	newLast = doc2.createNode("li")
	newLast.setInnerText("Final Item (Inserted After)")
	lastLi.insertAfter(newLast)
	? "9. Inserted item after last li"
ok

? copy("=", 70)
? "Modified HTML:"
? copy("=", 70)
? doc2.body().html()

# =====================================================================
# Navigation and Content Extraction
# =====================================================================
? copy("=", 70)
? "Advanced Navigation"
? copy("=", 70)

content = doc2.find("#content")[1]

? nl + "10. Navigating DOM Tree:"
? "    - Content div: " + content.tag() + " #" + content.attr("id")

# Get all attributes
attrs = content.attributes()
? "    - Attributes: " + len(attrs)
for attr in attrs
	? "      * " + attr[1] + " = '" + attr[2] + "'"
next

# First and last child
firstChild = content.firstChild()
lastChild = content.lastChild()

if not isNull(firstChild)
	? "    - First child: " + firstChild.tag()
	? "      Text: " + firstChild.text()
ok

if not isNull(lastChild)
	? "    - Last child: " + lastChild.tag()
	? "    - Inner HTML: " + lastChild.innerHTML()
ok

# =====================================================================
# Removing Elements
# =====================================================================
? copy("=", 70)
? "Removing Elements"
? copy("=", 70)

# Remove the old class paragraph (if it still exists)
oldParas = doc2.find("p.old")
if len(oldParas) > 0
	? nl + "11. Removing old paragraph..."
	oldParas[1].remove()
	? "    Removed successfully!"
ok

? copy("=", 70)
? "Final HTML After Removal:"
? copy("=", 70)
? doc2.body().html()

? nl + "Done!"