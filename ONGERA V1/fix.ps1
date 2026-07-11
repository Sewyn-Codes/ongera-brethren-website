$content = Get-Content -Path index.html -Raw -Encoding UTF8

$vanHtml = '          <!-- Van Project -->
          <article class="project-card reveal bg-white rounded-2xl overflow-hidden shadow-sm border border-slate-100 flex flex-col" style="transition-delay:0.2s">
            <div class="overflow-hidden">
              <img class="project-img" src="images/van.jpg" alt="Foundation transport van project" loading="lazy" width="600" height="210" style="object-fit:cover; background:#ccc;" />
            </div>
            <div class="p-6 flex flex-col flex-1">
              <div class="flex items-center justify-between mb-3">
                <span class="bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Transport</span>
                <span class="text-xs text-slate-400 font-medium">Ongoing</span>
              </div>
              <h3 class="text-2xl font-bold text-navy-900 mb-2 leading-snug">Foundation Van</h3>
              <p class="text-slate-500 text-sm leading-relaxed mb-4 flex-1">We are raising funds for a foundation van to transport our children and deliver supplies efficiently.</p>
              
              <div class="mb-4">
                <div class="flex justify-between text-xs font-bold mb-1">
                  <span class="text-slate-500">Progress</span>
                  <span class="text-orange-500">3%</span>
                </div>
                <div class="progress-track w-full">
                  <div class="progress-fill" style="width: 3%"></div>
                </div>
              </div>
              
              <a href="https://wa.me/254703424109?text=Hello%2C%20I%20want%20to%20support%20the%20Van%20project." target="_blank" rel="noopener noreferrer" class="mt-auto inline-flex items-center justify-center gap-2 bg-orange-500 hover:bg-orange-600 text-white font-bold text-[0.8rem] uppercase tracking-wider py-3 px-6 rounded-xl transition-all duration-200">
                <i class="fa-brands fa-whatsapp" aria-hidden="true"></i> Support Project
              </a>
            </div>
          </article>
'

# Find the first index of the vanHtml
$index = $content.IndexOf("<!-- Van Project -->")
if ($index -ge 0) {
    # Find the next index of <!-- Van Project -->
    $nextIndex = $content.IndexOf("<!-- Van Project -->", $index + 1)
    if ($nextIndex -ge 0) {
        # If it exists twice, remove the first one. 
        # The first one starts at $index and goes until $nextIndex
        # But wait, they are not strictly adjacent. 
        # The first van project is at the end of the impact section.
        # It's better to replace the first occurrence only.
        
        # We can substring the string to before the first van project, 
        # and after the first van project ends.
        # Let's find where the first van project ends.
        $endOfFirstVan = $content.IndexOf("</article>", $index) + 10 # length of </article>
        
        $content = $content.Substring(0, $index) + $content.Substring($endOfFirstVan)
        [IO.File]::WriteAllText("index.html", $content)
        Write-Host "Removed the first Van project."
    }
}
