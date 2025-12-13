# RingHTML Example 09: Unicode and International Text Support
# This example demonstrates how to handle Unicode text, international characters,
# and right-to-left languages like Arabic in HTML documents.

load "html.ring"

# Sample HTML content with various Unicode and international text
cHTML = `
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Unicode and International Text Example</title>
	<style>
		body { font-family: Arial, sans-serif; }
		.arabic { direction: rtl; font-family: 'Segoe UI', Tahoma; }
		.chinese { font-family: 'Microsoft YaHei', SimSun; }
		.emoji { font-family: 'Segoe UI Emoji', 'Apple Color Emoji'; }
	</style>
</head>
<body>
	<h1>🌍 Unicode and International Text Support</h1>

	<section class="arabic">
		<h2>العربية (Arabic)</h2>
		<p>السلام عليكم ورحمة الله وبركاته.</p>
		<p>لغة البرمجة رينج تم إنشائها بواسطة الدكتور/المهندس محمود سمير فايد</p>
		<div class="quote">
			<p>"اللغة العربية من أقدم اللغات وأكثرها غنىً في التعبير."</p>
			<cite>— المثل العربي</cite>
		</div>
	</section>

	<section class="chinese">
		<h2>中文 (Chinese)</h2>
		<p>你好，欢迎来到Unicode和国际文本支持的示例。</p>
		<p>这个例子展示了如何处理中文字符：我、你、他、我们、你们、他们、中文、计算机、编程、语言。</p>
		<p>中文是世界上使用人数最多的语言之一。</p>
		<div class="quote">
			<p>"学如逆水行舟，不进则退。"</p>
			<cite>— 中国谚语</cite>
		</div>
	</section>

	<section class="mixed">
		<h2>🌟 Mixed Languages and Emojis</h2>
		<p>English: Hello world! 👋</p>
		<p>Español: ¡Hola mundo! 🌎</p>
		<p>Français: Bonjour le monde! 🇫🇷</p>
		<p>Deutsch: Hallo Welt! 🇩🇪</p>
		<p>日本語: こんにちは世界！🎌</p>
		<p>Русский: Привет мир! 🇷🇺</p>
		<p>Emoji only: 🚀💻📱🎮🎵📚🎨⚽🏀🎯</p>
	</section>

	<section class="symbols">
		<h2>🔤 Special Characters and Symbols</h2>
		<h3>Mathematical Symbols</h3>
		<p>Mathematics: ∫ ∑ ∏ √ ± ∞ ≈ ≠ ≤ ≥ ≡ ∈ ∉ ⊂ ⊆ ⊃ ⊇ ∪ ∩ ∅</p>

		<h3>Currency Symbols</h3>
		<p>Money: $ € £ ¥ ₹ ₽ ₩ ₨ ¢ ₪ ₫ ₦ ₨ ₡ ₵ ₺ ₼</p>

		<h3>Punctuation and Typography</h3>
		<p>Typography: "Quotes" 'Apostrophes' – En dash — Em dash … Ellipsis ¡ Inverted exclamation ¿ Inverted question</p>
	</section>

	<section class="encoding">
		<h2>🧪 Encoding Test</h2>
		<div class="test-case">
			<h3>UTF-8 Characters</h3>
			<p>Normal text with special chars: naïve résumé café π ≈ 3.14159</p>
			<p>Combining characters: ã õ ñ (with tildes)</p>
			<p>Ligatures: æ œ ﬁ ﬂ ﬃ ﬄ (ae, oe, fi, fl, ffi, ffl)</p>
		</div>

		<div class="test-case">
			<h3>Right-to-Left Text</h3>
			<p class="arabic">العربية RTL: هذا النص يجب أن يظهر من اليمين إلى اليسار</p>
			<p>Mixed: Hello العالم World 世界</p>
		</div>
	</section>

	<section class="analysis">
		<h2>📊 Text Analysis</h2>
		<div id="stats">
			<h3>Character Statistics</h3>
			<p>This document contains text from multiple languages and character sets.</p>
			<ul>
				<li>Arabic: العربية</li>
				<li>Chinese: 中文</li>
				<li>English: English</li>
				<li>Spanish: Español</li>
				<li>French: Français</li>
				<li>German: Deutsch</li>
				<li>Japanese: 日本語</li>
				<li>Russian: Русский</li>
				<li>Emojis: 🌍🚀💻</li>
				<li>Math symbols: ∫∑√∞</li>
			</ul>
		</div>
	</section>
</body>
</html>
`

? "=== RingHTML: Unicode and International Text Support ===" + nl

# Parse the HTML document
doc = new HTML(cHTML)

? "✅ HTML document with Unicode content parsed successfully!" + nl

# Example 1: Basic Unicode text extraction
? "=== 1. Basic Unicode Text Extraction ==="

# Extract Arabic text
aArabicParas = doc.find(".arabic p")
? "Arabic paragraphs found: " + len(aArabicParas)
for i = 1 to len(aArabicParas)
	para = aArabicParas[i]
	? "Arabic text " + i + ": " + para.text()
next
see nl

# Extract Chinese text
aChineseParas = doc.find(".chinese p")
? "Chinese paragraphs found: " + len(aChineseParas)
for i = 1 to len(aChineseParas)
	para = aChineseParas[i]
	? "Chinese text " + i + ": " + para.text()
next
see nl

# Example 2: Mixed language extraction
? "=== 2. Mixed Language Text ==="

aMixedParas = doc.find(".mixed p")
? "Mixed language paragraphs found: " + len(aMixedParas)
for i = 1 to len(aMixedParas)
	para = aMixedParas[i]
	text = para.text()
	? "Mixed text " + i + ": " + text
next
see nl

# Example 3: Emoji extraction
? "=== 3. Emoji and Symbol Extraction ==="

aEmojiParas = doc.find(".emoji p")
if len(aEmojiParas) > 0
	emojiText = aEmojiParas[1].text()
	? "Emoji text: " + emojiText
ok

aSymbolParas = doc.find(".symbols p")
? "Symbol paragraphs found: " + len(aSymbolParas)
for i = 1 to len(aSymbolParas)
	para = aSymbolParas[i]
	text = para.text()
	? "Symbols " + i + ": " + text
next
see nl

# Example 4: Character encoding test
? "=== 4. Character Encoding Test ==="

aEncodingParas = doc.find(".encoding p")
? "Encoding test paragraphs found: " + len(aEncodingParas)
for i = 1 to len(aEncodingParas)
	para = aEncodingParas[i]
	text = para.text()
	? "Encoding test " + i + ": " + text
next
see nl

# Example 5: Language-specific analysis
? "=== 5. Language-Specific Analysis ==="

# Count characters in different languages
aArabicText = doc.find(".arabic")
if len(aArabicText) > 0
	arabicContent = aArabicText[1].text()
	? "Arabic content length: " + len(arabicContent) + " characters"
	? "Arabic sample: " + substr(arabicContent, 1, 50) + "..."
ok

aChineseText = doc.find(".chinese")
if len(aChineseText) > 0
	chineseContent = aChineseText[1].text()
	? "Chinese content length: " + len(chineseContent) + " characters"
	? "Chinese sample: " + substr(chineseContent, 1, 30) + "..."
ok

# Example 6: RTL (Right-to-Left) text handling
? "=== 6. RTL Text Direction Analysis ==="

aRTLElements = doc.find("[dir='rtl'], .arabic")
? "RTL elements found: " + len(aRTLElements)

aArabicElements = doc.find(".arabic")
if len(aArabicElements) > 0
	? "Arabic elements with RTL direction:"
	for i = 1 to len(aArabicElements)
		element = aArabicElements[i]
		if element.has_attr("dir")
			? "  Element " + i + " direction: " + element.attr("dir")
		else
			? "  Element " + i + " (no explicit direction)"
		ok
	next
ok
see nl

# Example 7: Unicode character statistics
? "=== 7. Unicode Character Statistics ==="

# Get all text content
allText = NULL
aAllParas = doc.find("p")
for i = 1 to len(aAllParas)
	para = aAllParas[i]
	allText += para.text() + " "
next

? "Total characters in document: " + len(allText)
? "Sample of all text: " + substr(allText, 1, 183) + "..."

# Example 8: International content validation
? "=== 8. International Content Validation ==="

# Check if Arabic text is preserved correctly
aArabicQuotes = doc.find(".arabic .quote p")
if len(aArabicQuotes) > 0
	arabicQuote = aArabicQuotes[1].text()
	? "Arabic quote preserved: " + arabicQuote
	? "Quote length: " + len(arabicQuote) + " characters"
ok

# Check if Chinese text is preserved correctly
aChineseQuotes = doc.find(".chinese .quote p")
if len(aChineseQuotes) > 0
	chineseQuote = aChineseQuotes[1].text()
	? "Chinese proverb preserved: " + chineseQuote
	? "Proverb length: " + len(chineseQuote) + " characters"
ok

# Check if emojis are preserved
aEmojiElements = doc.find("h1")
if len(aEmojiElements) > 0
	titleText = aEmojiElements[1].text()
	? "Title with emoji preserved: " + titleText
	if substr(titleText, "🌍") != NULL
		? "Title contains emoji: Yes"
	else
		? "Title contains emoji: No"
	ok
ok
see nl

