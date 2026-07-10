import sys
import re

path = r'c:\Users\Sophie\Desktop\ONGERA V1\index.html'

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Global Typography
globalCSS = """
    /* -- Global -- */
    *, *::before, *::after { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body { font-family: 'Inter', system-ui, sans-serif; background: #f8f9fb; color: #1a1a2e; }
    h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', Georgia, serif; }
    p { line-height: 1.75; }
"""
content = re.sub(r'/\*\s*── Global.*?\n.*?body \{.*?\n', globalCSS.strip() + '\n', content, flags=re.DOTALL)

# 2. Classic styling for buttons
content = content.replace('text-sm py-3 px-5', 'text-[0.8rem] uppercase tracking-wider py-3 px-6')
content = content.replace('text-base px-8 py-4', 'text-sm uppercase tracking-widest px-8 py-4')
content = content.replace('font-bold px-8 py-3.5 rounded-xl', 'font-bold uppercase tracking-wider text-sm px-8 py-3.5 rounded-xl')
content = content.replace('text-sm px-5 py-3 rounded-xl transition-all', 'text-[0.8rem] uppercase tracking-wider px-6 py-3 rounded-xl transition-all')

# 3. Classic styling for Project Cards
content = content.replace('<h3 class="text-xl font-bold text-navy-900 mb-2">', '<h3 class="text-2xl font-bold text-navy-900 mb-2 leading-snug">')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Classic alignments and typography applied via Python.")
