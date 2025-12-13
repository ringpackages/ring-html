# RingHTML - HTML5 Parser with CSS Selectors
# A high-performance HTML5 parser built on the Lexbor C library

class HTML
	# Document pointer to the parsed HTML
	pDoc

	# Parse an HTML string and create a document object
	func init html
		pDoc = html_parse(html)
		if isNull(pDoc)
			raise("Failed to parse HTML document.")
		ok

	# Find all elements matching a CSS selector
	# Returns: list of HTMLNode objects
	func find selector
		aNodes = html_find(pDoc, selector)
		aResult = []
		for pNode in aNodes
			aResult + new HTMLNode(pNode)
		next
		return aResult

	# Get the <body> element
	# Returns: HTMLNode or NULL
	func body
		pBodyNode = html_get_body(pDoc)
		if not isNull(pBodyNode)
			return new HTMLNode(pBodyNode)
		ok
		return NULL

	# Create a new element with the given tag name
	# Returns: HTMLNode (not attached to DOM until inserted)
	func createNode tagName
		pNode = html_create_element(pDoc, tagName)
		if not isNull(pNode)
			return new HTMLNode(pNode)
		ok
		return NULL

	# Create a new text node with the given content
	# Returns: HTMLNode (not attached to DOM until inserted)
	func createTextNode text
		pNode = html_create_text_node(pDoc, text)
		if not isNull(pNode)
			return new HTMLNode(pNode)
		ok
		return NULL

	# Get the root <html> element
	# Returns: HTMLNode or NULL
	func root
		pRootNode = html_get_root(pDoc)
		if not isNull(pRootNode)
			return new HTMLNode(pRootNode)
		ok
		return NULL

	# Alias for root()
	func html
		return root()

	# Get the <head> element
	# Returns: HTMLNode or NULL
	func head
		pHeadNode = html_get_head(pDoc)
		if not isNull(pHeadNode)
			return new HTMLNode(pHeadNode)
		ok
		return NULL

class HTMLNode
	# Pointer to the DOM node
	pNode

	# Initialize from a C pointer (internally used)
	func init node
		if islist(node) and len(node) > 0
			pNode = node[1]
		else
			pNode = node
		ok

	# Find descendant elements matching a CSS selector
	# Returns: list of HTMLNode objects
	func find selector
		if isNull(pNode)
			return []
		ok
		aNodes = html_find(pNode, selector)
		aResult = []
		for node in aNodes
			aResult + new HTMLNode(node)
		next
		return aResult

	# Get the combined text content of this node and its descendants
	func text
		if isNull(pNode)
			return NULL
		ok
		return html_node_text(pNode)

	# Get the outer HTML of this element (including the tag itself)
	func html
		if isNull(pNode)
			return NULL
		ok
		return html_node_html(pNode)

	# Get the tag name (e.g., "DIV", "P", "A")
	func tag
		if isNull(pNode)
			return NULL
		ok
		return html_node_tag(pNode)

	# Get the value of an attribute
	func attr name
		if isNull(pNode)
			return NULL
		ok
		return html_node_attr(pNode, name)

	# Get the parent element
	# Returns: HTMLNode or NULL
	func parent
		if isNull(pNode)
			return NULL
		ok
		try
			pParent = html_node_parent(pNode)
		catch
			return NULL
		done
		if not isNull(pParent)
			parentNode = new HTMLNode
			parentNode.pNode = pParent
			return parentNode
		ok
		return NULL

	# Get the next sibling element
	# Returns: HTMLNode or NULL
	func next_sibling
		if isNull(pNode)
			return NULL
		ok
		try
			pSibling = html_node_next_sibling(pNode)
		catch
			return NULL
		done
		if not isNull(pSibling)
			siblingNode = new HTMLNode(pSibling)
			return siblingNode
		ok
		return NULL

	# Get the previous sibling element
	# Returns: HTMLNode or NULL
	func prev_sibling
		if isNull(pNode)
			return NULL
		ok
		try
			pSibling = html_node_prev_sibling(pNode)
		catch
			return NULL
		done
		if not isNull(pSibling)
			siblingNode = new HTMLNode(pSibling)
			return siblingNode
		ok
		return NULL

	# Get all child elements
	# Returns: list of HTMLNode objects
	func children
		if isNull(pNode)
			return []
		ok
		aNodes = html_node_children(pNode)
		aResult = []
		for node in aNodes
			aResult + new HTMLNode(node)
		next
		return aResult

	# Check if an attribute exists
	# Returns: true or false
	func has_attr name
		if isNull(pNode)
			return false
		ok
		return html_node_has_attr(pNode, name)

	# Append a child node to this element
	func appendChild childNode
		if isNull(pNode) or isNull(childNode)
			raise("Cannot append child: invalid node")
		ok
		childPointer = childNode.pNode
		html_node_append_child(pNode, childPointer)

	# Insert a node before this element (as a sibling)
	func insertBefore newNode
		if isNull(pNode) or isNull(newNode)
			raise("Cannot insert before: invalid node")
		ok
		newPointer = newNode.pNode
		html_node_insert_before(pNode, newPointer)

	# Insert a node after this element (as a sibling)
	func insertAfter newNode
		if isNull(pNode) or isNull(newNode)
			raise("Cannot insert after: invalid node")
		ok
		newPointer = newNode.pNode
		html_node_insert_after(pNode, newPointer)

	# Remove this element from the DOM
	func remove
		if isNull(pNode)
			raise("Cannot remove: invalid node")
		ok
		html_node_remove(pNode)

	# Set or update an attribute value
	func setAttribute name, value
		if isNull(pNode)
			raise("Cannot set attribute: invalid node")
		ok
		html_node_set_attr(pNode, name, value)

	# Remove an attribute
	func removeAttribute name
		if isNull(pNode)
			raise("Cannot remove attribute: invalid node")
		ok
		html_node_remove_attr(pNode, name)

	# Get all attributes as a list of [name, value] pairs
	func attributes
		if isNull(pNode)
			return []
		ok
		return html_node_get_all_attrs(pNode)

	# Set the text content, replacing all children
	func setInnerText text
		if isNull(pNode)
			raise("Cannot set inner text: invalid node")
		ok
		html_node_set_inner_text(pNode, text)

	# Set the inner HTML, replacing all children
	func setInnerHTML html
		if isNull(pNode)
			raise("Cannot set inner HTML: invalid node")
		ok
		html_node_set_inner_html(pNode, html)

	# Get the first child element
	# Returns: HTMLNode or NULL
	func firstChild
		if isNull(pNode)
			return NULL
		ok
		pChild = html_node_first_child(pNode)
		if not isNull(pChild)
			return new HTMLNode(pChild)
		ok
		return NULL

	# Get the last child element
	# Returns: HTMLNode or NULL
	func lastChild
		if isNull(pNode)
			return NULL
		ok
		pChild = html_node_last_child(pNode)
		if not isNull(pChild)
			return new HTMLNode(pChild)
		ok
		return NULL

	# Get the inner HTML content (children only, without outer tag)
	func innerHTML
		if isNull(pNode)
			return NULL
		ok
		return html_node_inner_html(pNode)