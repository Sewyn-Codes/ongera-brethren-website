$path = "c:\Users\Sophie\Desktop\ONGERA V1\index.html"
$content = Get-Content $path -Raw -Encoding UTF8

# 1. Clean up mojibake from project & newsletter pills
# Instead of matching the exact mojibake, we'll just regex replace the content inside the spans
$content = $content -replace '(?s)<span class="bg-navy-900 text-orange-400 text-xs font-bold px-3 py-1 rounded-full">.*?Church</span>', '<span class="bg-navy-900 text-orange-400 text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Church</span>'
$content = $content -replace '(?s)<span class="bg-earth-600 text-white text-xs font-bold px-3 py-1 rounded-full">.*?Agriculture</span>', '<span class="bg-earth-600 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Agriculture</span>'
$content = $content -replace '(?s)<span class="bg-red-500 text-white text-xs font-bold px-3 py-1 rounded-full">.*?Outreach</span>', '<span class="bg-red-500 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Outreach</span>'
$content = $content -replace '(?s)<span class="bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full">.*?Education</span>', '<span class="bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Education</span>'
$content = $content -replace '(?s)<span class="bg-orange-100 text-orange-700 text-xs font-bold px-3 py-1 rounded-full">.*?Nutrition</span>', '<span class="bg-orange-100 text-orange-700 text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Nutrition</span>'
$content = $content -replace '(?s)<span class="inline-block bg-white/20 text-white text-xs font-bold px-4 py-1.5 rounded-full mb-5 border border-white/30 backdrop-blur-sm shadow-sm">.*?Stay Updated</span>', '<span class="inline-block bg-white/20 text-white text-xs font-bold px-4 py-1.5 rounded-full mb-5 border border-white/30 backdrop-blur-sm shadow-sm uppercase tracking-wider">Stay Updated</span>'
# Also fix the weird em dash mojibake "â€”"
$content = $content -replace 'â€”', '&mdash;'


# 2. Add Gallery to Menu
# Desktop nav
$desktopNavGallery = '<a href="#projects" class="text-slate-300 hover:text-orange-400 text-sm font-medium transition-colors">Projects</a>`n          <a href="#gallery" class="text-slate-300 hover:text-orange-400 text-sm font-medium transition-colors">Gallery</a>'
$content = $content -replace '<a href="#projects" class="text-slate-300 hover:text-orange-400 text-sm font-medium transition-colors">Projects</a>', $desktopNavGallery

# Mobile nav
$mobileNavGallery = '<a href="#projects" class="mobile-nav-link text-slate-200 hover:text-orange-400 py-2 px-2 text-sm font-medium transition-colors">Projects</a>`n          <a href="#gallery" class="mobile-nav-link text-slate-200 hover:text-orange-400 py-2 px-2 text-sm font-medium transition-colors">Gallery</a>'
$content = $content -replace '<a href="#projects" class="mobile-nav-link text-slate-200 hover:text-orange-400 py-2 px-2 text-sm font-medium transition-colors">Projects</a>', $mobileNavGallery


# 3. Insert Gallery Section before Newsletter
$galleryHTML = @"
    <!-- =====================================================
         GALLERY
    ====================================================== -->
    <section id="gallery" class="bg-white py-20 px-4">
      <div class="max-w-6xl mx-auto">
        <div class="text-center mb-14 reveal">
          <span class="section-eyebrow">Visual Journey</span>
          <h2 class="text-3xl sm:text-4xl font-display font-bold text-navy-900 mt-1">Our Impact in Pictures</h2>
          <p class="text-slate-500 mt-3 max-w-xl mx-auto">A glimpse into the daily lives, joy, and resilience of the community we serve.</p>
        </div>

        <div class="masonry-grid reveal" style="transition-delay:0.1s">
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/youth-community.jpg" alt="Youth community members gathering outdoors" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/church-men.jpg" alt="Foundation leaders and members standing outside the stone church building" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/agriculture-women.jpg" alt="Women of the community sorting agricultural produce outside" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/christmas-distribution.jpg" alt="Distribution of supplies to the less fortunate during outreach" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/visitor-inside.jpg" alt="An international visitor with an elder of the foundation" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
          <div class="masonry-item" onclick="openLightbox(this.querySelector('img').src, this.querySelector('img').alt)">
            <img src="images/children-with-visitor.jpg" alt="Children and visitors" loading="lazy" />
            <div class="masonry-overlay"><i class="fa-solid fa-magnifying-glass-plus text-white text-3xl opacity-80"></i></div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- LIGHTBOX -->
    <div id="lightbox" role="dialog" aria-modal="true" aria-label="Image gallery fullscreen view" tabindex="-1">
      <button id="lightbox-close" class="absolute top-6 right-6 w-10 h-10 bg-white/10 hover:bg-white/20 rounded-full flex items-center justify-center text-white transition-colors" aria-label="Close fullscreen view">
        <i class="fa-solid fa-xmark text-xl" aria-hidden="true"></i>
      </button>
      <img id="lightbox-img" src="" alt="" />
      <p id="lightbox-caption"></p>
    </div>

    <!-- =====================================================
         NEWSLETTER / NEWS SECTOR
"@

$content = $content -replace '(?s)<!-- =====================================================\s*NEWSLETTER / NEWS SECTOR', $galleryHTML

# 4. Re-inject Lightbox JS script logic
$lightboxScript = @"
    /* 11. ANIMATED COUNTERS */
"@
$lightboxInsert = @"
    /* 12. LIGHTBOX */
    const lightbox = document.getElementById('lightbox');
    const lightboxImg = document.getElementById('lightbox-img');
    const lightboxCap = document.getElementById('lightbox-caption');
    window.openLightbox = function(src, alt) {
      lightboxImg.src = src; lightboxImg.alt = alt; lightboxCap.textContent = alt;
      lightbox.classList.add('active'); lightbox.focus();
    };
    document.getElementById('lightbox-close')?.addEventListener('click', () => lightbox.classList.remove('active'));
    lightbox?.addEventListener('click', e => { if(e.target === lightbox) lightbox.classList.remove('active'); });
    document.addEventListener('keydown', e => { if(e.key === 'Escape') lightbox?.classList.remove('active'); });

    /* 11. ANIMATED COUNTERS */
"@

$content = $content -replace '\/\*\s*11\. ANIMATED COUNTERS\s*\*\/', $lightboxInsert

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Output "Gallery and mojibake fixed."
