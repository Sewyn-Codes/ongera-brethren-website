const fs = require('fs');
const path = 'c:/Users/Sophie/Desktop/ONGERA V1/index.html';
let content = fs.readFileSync(path, 'utf8');

// 1. Global Typography & Classic Alignment
const globalCSS = `
    /* -- Global -- */
    *, *::before, *::after { box-sizing: border-box; }
    html { scroll-behavior: smooth; }
    body { font-family: 'Inter', system-ui, sans-serif; background: #f8f9fb; color: #1a1a2e; }
    h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', Georgia, serif; }
    p { line-height: 1.75; }
`;
// Replace the exact Global section with our new one
content = content.replace(/\/\*\s*── Global.*?html \{.*?\n.*?body \{.*?\n/s, globalCSS);

// 2. Make buttons have classic styling (uppercase, tracking wider)
content = content.replace(/text-sm py-3 px-5/g, 'text-[0.8rem] uppercase tracking-wider py-3 px-6');
content = content.replace(/text-base px-8 py-4/g, 'text-sm uppercase tracking-widest px-8 py-4');
content = content.replace(/font-bold px-8 py-3\.5 rounded-xl/g, 'font-bold uppercase tracking-wider text-sm px-8 py-3.5 rounded-xl');
content = content.replace(/text-sm px-5 py-3 rounded-xl transition-all/g, 'text-[0.8rem] uppercase tracking-wider px-6 py-3 rounded-xl transition-all');

// 3. Add classic styling to project cards
content = content.replace(/<h3 class="text-xl font-bold text-navy-900 mb-2">/g, '<h3 class="text-2xl font-bold text-navy-900 mb-2 leading-snug">');

fs.writeFileSync(path, content, 'utf8');
console.log("Classic alignments and typography applied.");
