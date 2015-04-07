all:
	generate-md --layout github --input ./src --output .
install:
	npm install -g markdown-styles
