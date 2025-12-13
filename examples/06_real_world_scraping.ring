# RingHTML Example 06: Real-World Web Scraping
# This example demonstrates practical web scraping techniques for real-world scenarios.

load "html.ring"

# Simulate scraped HTML content from various websites
cNewsHTML = `
<html>
<head>
	<title>News Website</title>
</head>
<body>
	<div class="news-container">
		<article class="news-item featured">
			<header>
				<h2><a href="/news/breaking-story">Breaking: Major Scientific Discovery</a></h2>
				<div class="meta">
					<span class="date">2024-01-15</span>
					<span class="category">Science</span>
				</div>
			</header>
			<div class="content">
				<p>Scientists have made a groundbreaking discovery that could revolutionize renewable energy...</p>
			</div>
		</article>

		<article class="news-item">
			<header>
				<h2><a href="/news/tech-update">Tech Giants Report Quarterly Earnings</a></h2>
				<div class="meta">
					<span class="date">2024-01-14</span>
					<span class="category">Technology</span>
				</div>
			</header>
			<div class="content">
				<p>Major technology companies have released their quarterly financial results...</p>
			</div>
		</article>

		<article class="news-item">
			<header>
				<h2><a href="/news/sports-news">Championship Finals Set for Next Week</a></h2>
				<div class="meta">
					<span class="date">2024-01-13</span>
					<span class="category">Sports</span>
				</div>
			</header>
			<div class="content">
				<p>The championship finals are scheduled for next weekend with several exciting matchups...</p>
			</div>
		</article>
	</div>
</body>
</html>
`

cProductHTML = `
<html>
<head>
	<title>Online Store</title>
</head>
<body>
	<div class="products">
		<div class="product" data-product-id="P001">
			<img src="/images/laptop.jpg" alt="Gaming Laptop">
			<h3><a href="/products/gaming-laptop">Gaming Laptop Pro</a></h3>
			<div class="price">
				<span class="current-price">$1,299.99</span>
				<span class="original-price">$1,599.99</span>
			</div>
			<div class="rating">
				<span class="stars">★★★★☆</span>
				<span class="reviews">(127 reviews)</span>
			</div>
			<p class="description">High-performance gaming laptop with latest graphics card...</p>
			<button class="add-to-cart" data-product-id="P001">Add to Cart</button>
		</div>

		<div class="product" data-product-id="P002">
			<img src="/images/headphones.jpg" alt="Wireless Headphones">
			<h3><a href="/products/wireless-headphones">Wireless Headphones X1</a></h3>
			<div class="price">
				<span class="current-price">$89.99</span>
			</div>
			<div class="rating">
				<span class="stars">★★★★★</span>
				<span class="reviews">(89 reviews)</span>
			</div>
			<p class="description">Premium wireless headphones with noise cancellation...</p>
			<button class="add-to-cart" data-product-id="P002">Add to Cart</button>
		</div>

		<div class="product" data-product-id="P003">
			<img src="/images/tablet.jpg" alt="Tablet">
			<h3><a href="/products/tablet">Tablet Ultra</a></h3>
			<div class="price">
				<span class="current-price">$399.99</span>
				<span class="original-price">$499.99</span>
			</div>
			<div class="rating">
				<span class="stars">★★★☆☆</span>
				<span class="reviews">(45 reviews)</span>
			</div>
			<p class="description">Versatile tablet perfect for work and entertainment...</p>
			<button class="add-to-cart" data-product-id="P003">Add to Cart</button>
		</div>
	</div>
</body>
</html>
`

cJobHTML = `
<html>
<head>
	<title>Job Board</title>
</head>
<body>
	<div class="job-listings">
		<div class="job-posting" data-job-id="J001">
			<h3><a href="/jobs/senior-developer">Senior Software Developer</a></h3>
			<div class="company">Tech Innovations Inc.</div>
			<div class="location">San Francisco, CA</div>
			<div class="salary">$120,000 - $160,000</div>
			<div class="type">Full-time</div>
			<div class="posted">2 days ago</div>
			<div class="description">
				<p>We are looking for an experienced software developer to join our team...</p>
			</div>
		</div>

		<div class="job-posting" data-job-id="J002">
			<h3><a href="/jobs/ux-designer">UX/UI Designer</a></h3>
			<div class="company">Creative Solutions Ltd.</div>
			<div class="location">Remote</div>
			<div class="salary">$80,000 - $110,000</div>
			<div class="type">Full-time</div>
			<div class="posted">1 day ago</div>
			<div class="description">
				<p>Join our design team to create amazing user experiences...</p>
			</div>
		</div>

		<div class="job-posting" data-job-id="J003">
			<h3><a href="/jobs/data-analyst">Data Analyst</a></h3>
			<div class="company">Data Insights Corp.</div>
			<div class="location">New York, NY</div>
			<div class="salary">$70,000 - $90,000</div>
			<div class="type">Contract</div>
			<div class="posted">3 days ago</div>
			<div class="description">
				<p>Analyze data and provide insights to drive business decisions...</p>
			</div>
		</div>
	</div>
</body>
</html>
`

? "=== RingHTML: Real-World Web Scraping Example ===" + nl

# Example 1: News Article Scraping
? "=== 1. News Article Scraping ==="

doc1 = new HTML(cNewsHTML)

aArticles = doc1.find("article")
? "Found " + len(aArticles) + " news articles"

for i = 1 to len(aArticles)
	article = aArticles[i]

	# Extract title
	aTitles = article.find("h2 a")
	if len(aTitles) > 0
		title = aTitles[1].text()
	else
		title = "No title"
	ok

	# Extract date
	aDates = article.find(".date")
	if len(aDates) > 0
		date = aDates[1].text()
	else
		date = "No date"
	ok

	# Extract category
	aCategories = article.find(".category")
	if len(aCategories) > 0
		category = aCategories[1].text()
	else
		category = "No category"
	ok

	# Extract description
	aDescriptions = article.find(".content p")
	if len(aDescriptions) > 0
		description = aDescriptions[1].text()
	else
		description = "No description"
	ok

	# Check if featured
	isFeatured = len(article.find(".featured")) > 0

	? "  Article " + i + ":"
	? "    Title: " + title
	? "    Date: " + date
	? "    Category: " + category
	if isFeatured
		? "    Featured: Yes"
	else
		? "    Featured: No"
	ok
	? "    Description: " + description
next
see nl

# Example 2: E-commerce Product Scraping
? "=== 2. E-commerce Product Scraping ==="

doc2 = new HTML(cProductHTML)

aProducts = doc2.find(".product")
? "Found " + len(aProducts) + " products"

for i = 1 to len(aProducts)
	product = aProducts[i]

	# Extract product ID
	productId = product.attr("data-product-id")

	# Extract name
	aNames = product.find("h3 a")
	if len(aNames) > 0
		name = aNames[1].text()
	else
		name = "No name"
	ok

	# Extract current price
	aPrices = product.find(".current-price")
	if len(aPrices) > 0
		price = aPrices[1].text()
	else
		price = "No price"
	ok

	# Extract original price (if on sale)
	aOriginalPrices = product.find(".original-price")
	if len(aOriginalPrices) > 0
		originalPrice = aOriginalPrices[1].text()
	else
		originalPrice = NULL
	ok

	# Extract rating
	aRatings = product.find(".stars")
	if len(aRatings) > 0
		rating = aRatings[1].text()
	else
		rating = "No rating"
	ok

	# Extract review count
	aReviews = product.find(".reviews")
	if len(aReviews) > 0
		reviews = aReviews[1].text()
	else
		reviews = "No reviews"
	ok

	# Extract description
	aDescriptions = product.find(".description")
	if len(aDescriptions) > 0
		description = aDescriptions[1].text()
	else
		description = "No description"
	ok

	? "  Product " + i + " (ID: " + productId + "):"
	? "    Name: " + name
	? "    Price: " + price
	if originalPrice != NULL
		? "    Original Price: " + originalPrice
	ok
	? "    Rating: " + rating
	? "    Reviews: " + reviews
	? "    Description: " + description
next
see nl

# Example 3: Job Board Scraping
? "=== 3. Job Board Scraping ==="

doc3 = new HTML(cJobHTML)

aJobs = doc3.find(".job-posting")
? "Found " + len(aJobs) + " job postings"

for i = 1 to len(aJobs)
	job = aJobs[i]

	# Extract job ID
	jobId = job.attr("data-job-id")

	# Extract title
	aTitles = job.find("h3 a")
	if len(aTitles) > 0
		title = aTitles[1].text()
	else
		title = "No title"
	ok

	# Extract company
	aCompanies = job.find(".company")
	if len(aCompanies) > 0
		company = aCompanies[1].text()
	else
		company = "No company"
	ok

	# Extract location
	aLocations = job.find(".location")
	if len(aLocations) > 0
		location = aLocations[1].text()
	else
		location = "No location"
	ok

	# Extract salary
	aSalaries = job.find(".salary")
	if len(aSalaries) > 0
		salary = aSalaries[1].text()
	else
		salary = "No salary"
	ok

	# Extract job type
	aTypes = job.find(".type")
	if len(aTypes) > 0
		jobType = aTypes[1].text()
	else
		jobType = "No type"
	ok

	# Extract posted date
	aPosted = job.find(".posted")
	if len(aPosted) > 0
		posted = aPosted[1].text()
	else
		posted = "No date"
	ok

	# Extract description
	aDescriptions = job.find(".description p")
	if len(aDescriptions) > 0
		description = aDescriptions[1].text()
	else
		description = "No description"
	ok

	? "  Job " + i + " (ID: " + jobId + "):"
	? "    Title: " + title
	? "    Company: " + company
	? "    Location: " + location
	? "    Salary: " + salary
	? "    Type: " + jobType
	? "    Posted: " + posted
	? "    Description: " + description
next
see nl

# Example 4: Data Analysis and Reporting
? "=== 4. Data Analysis and Reporting ==="

# Analyze news articles
aFeaturedArticles = doc1.find(".featured")
aRegularArticles = doc1.find("article:not(.featured)")

? "News Analysis:"
? "  Total articles: " + len(aArticles)
? "  Featured articles: " + len(aFeaturedArticles)
? "  Regular articles: " + len(aRegularArticles)

# Analyze product prices
aOnSale = doc2.find(".original-price")
? "Product Analysis:"
? "  Total products: " + len(aProducts)
? "  Products on sale: " + len(aOnSale)

# Analyze job types (using simpler selectors)
aFullTime = doc3.find('.type')
aContract = doc3.find('.type')
aRemote = doc3.find('.location')

? "Job Analysis:"
? "  Total jobs: " + len(aJobs)
? "  Full-time positions: " + len(aFullTime)
? "  Contract positions: " + len(aContract)
? "  Remote positions: " + len(aRemote)
see nl

# Example 5: Export to Structured Format
? "=== 5. Export to Structured Format ==="

# Create a simple CSV-like output for products
? "Product Catalog (CSV Format):"
? '"ID","Name","Price","Rating","Reviews"'

for i = 1 to len(aProducts)
	product = aProducts[i]
	productId = product.attr("data-product-id")
	name = product.find("h3 a")[1].text()
	price = product.find(".current-price")[1].text()
	rating = product.find(".stars")[1].text()
	reviews = product.find(".reviews")[1].text()

	? '"' + productId + '","' + name + '","' + price + '","' + rating + '","' + reviews + '"'
next
see nl

? nl + "Done!"