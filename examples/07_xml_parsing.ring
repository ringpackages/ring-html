# RingHTML Example 07: XML Parsing
# This example demonstrates how to parse and extract data from XML documents.

load "html.ring"

# Sample XML content for demonstration
cXML = `
<?xml version="1.0" encoding="UTF-8"?>
<library>
	<books>
		<book id="1" category="fiction">
			<title>The Great Gatsby</title>
			<author>F. Scott Fitzgerald</author>
			<year>1925</year>
			<price>10.99</price>
			<description>A classic American novel</description>
		</book>
		<book id="2" category="technology">
			<title>Clean Code</title>
			<author>Robert C. Martin</author>
			<year>2008</year>
			<price>29.99</price>
			<description>A handbook of agile software craftsmanship</description>
		</book>
		<book id="3" category="science">
			<title>A Brief History of Time</title>
			<author>Stephen Hawking</author>
			<year>1988</year>
			<price>15.50</price>
			<description>An exploration of the universe</description>
		</book>
	</books>

	<readers>
		<reader id="101">
			<name>Alice Johnson</name>
			<email>alice@example.com</email>
			<books_read>25</books_read>
		</reader>
		<reader id="102">
			<name>Bob Smith</name>
			<email>bob@example.com</email>
			<books_read>42</books_read>
		</reader>
	</readers>

	<categories>
		<category name="fiction" count="1" />
		<category name="technology" count="1" />
		<category name="science" count="1" />
	</categories>
</library>
`

? "=== RingHTML: XML Parsing Example ===" + nl

# Parse the XML document
doc = new HTML(cXML)

? "✅ XML document parsed successfully!" + nl

# Example 1: Basic XML structure parsing
? "=== 1. Basic XML Structure ==="

# Get all books
aBooks = doc.find("book")
? "Total books found: " + len(aBooks)

# Get all readers
aReaders = doc.find("reader")
? "Total readers found: " + len(aReaders)

# Get all categories
aCategories = doc.find("category")
? "Total categories found: " + len(aCategories) + nl

# Example 2: Extract book information
? "=== 2. Book Information Extraction ==="

? "Library Books:"
for i = 1 to len(aBooks)
	book = aBooks[i]

	# Extract book details
	title = NULL
	author = NULL
	year = NULL
	price = NULL
	category = NULL

	# Get title
	aTitles = book.find("title")
	if len(aTitles) > 0
		title = aTitles[1].text()
	ok

	# Get author
	aAuthors = book.find("author")
	if len(aAuthors) > 0
		author = aAuthors[1].text()
	ok

	# Get year
	aYears = book.find("year")
	if len(aYears) > 0
		year = aYears[1].text()
	ok

	# Get price
	aPrices = book.find("price")
	if len(aPrices) > 0
		price = aPrices[1].text()
	ok

	# Get category attribute
	if book.has_attr("category")
		category = book.attr("category")
	ok

	? "  Book " + i + ":"
	? "    Title: " + title
	? "    Author: " + author
	? "    Year: " + year
	? "    Price: $" + price
	? "    Category: " + category
next
see nl

# Example 3: Extract reader information
? "=== 3. Reader Information Extraction ==="

? "Library Readers:"
for i = 1 to len(aReaders)
	reader = aReaders[i]

	# Extract reader details
	name = NULL
	email = NULL
	booksRead = NULL

	# Get name
	aNames = reader.find("name")
	if len(aNames) > 0
		name = aNames[1].text()
	ok

	# Get email
	aEmails = reader.find("email")
	if len(aEmails) > 0
		email = aEmails[1].text()
	ok

	# Get books read
	aBooksRead = reader.find("books_read")
	if len(aBooksRead) > 0
		booksRead = aBooksRead[1].text()
	ok

	? "  Reader " + i + ":"
	? "    Name: " + name
	? "    Email: " + email
	? "    Books Read: " + booksRead
next
see nl

# Example 4: Category analysis
? "=== 4. Category Analysis ==="

? "Book Categories:"
for i = 1 to len(aCategories)
	category = aCategories[i]

	# Get category name and count
	name = NULL
	count = NULL

	if category.has_attr("name")
		name = category.attr("name")
	ok

	if category.has_attr("count")
		count = category.attr("count")
	ok

	? "  " + name + " (" + count + " books)"
next
see nl

# Example 5: Advanced XML queries
? "=== 5. Advanced XML Queries ==="

# Find all technology books
aTechBooks = doc.find("book[category='technology']")
? "Technology books found: " + len(aTechBooks)
if len(aTechBooks) > 0
	techBook = aTechBooks[1]
	? "First tech book: " + techBook.find("title")[1].text()
ok

# Find books published after 2000
aModernBooks = doc.find("book")
? "Books published after 2000:"
for i = 1 to len(aModernBooks)
	book = aModernBooks[i]
	aYears = book.find("year")
	if len(aYears) > 0
		year = number(aYears[1].text())
		if year > 2000
			title = book.find("title")[1].text()
			? "  " + title + " (" + year + ")"
		ok
	ok
next
see nl

# Example 6: XML structure navigation
? "=== 6. XML Structure Navigation ==="

# Navigate from books to their parent
if len(aBooks) > 0
	firstBook = aBooks[1]
	? "First book title: " + firstBook.find("title")[1].text()

	# Get parent (books element)
	booksParent = firstBook.parent()
	if not isnull(booksParent)
		? "Parent element: " + booksParent.tag()
	ok

	# Get root element
	libraryRoot = booksParent.parent()
	if not isnull(libraryRoot)
		? "Root element: " + libraryRoot.tag()
	ok
ok
see nl

# Example 7: XML statistics
? "=== 7. XML Statistics ==="

# Calculate total value of all books
totalValue = 0
for i = 1 to len(aBooks)
	book = aBooks[i]
	aPrices = book.find("price")
	if len(aPrices) > 0
		price = number(aPrices[1].text())
		totalValue += price
	ok
next

? "Library Statistics:"
? "  Total books: " + len(aBooks)
? "  Total readers: " + len(aReaders)
? "  Total categories: " + len(aCategories)
? "  Total inventory value: $" + totalValue

# Find most expensive book
mostExpensive = 0
expensiveBook = NULL
for i = 1 to len(aBooks)
	book = aBooks[i]
	aPrices = book.find("price")
	if len(aPrices) > 0
		price = number(aPrices[1].text())
		if price > mostExpensive
			mostExpensive = price
			expensiveBook = book.find("title")[1].text()
		ok
	ok
next
? "  Most expensive book: " + expensiveBook + " ($" + mostExpensive + ")"
see nl