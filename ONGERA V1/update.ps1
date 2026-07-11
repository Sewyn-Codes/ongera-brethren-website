$content = Get-Content -Path index.html -Raw -Encoding UTF8

$content = $content.Replace("info@ongerabrethren.org", "ongerainternationalorganization@gmail.com")
$content = $content.Replace('sameAs": ["https://www.facebook.com/ongerabrethren"]', 'sameAs": ["https://www.facebook.com/profile.php?id=61582846529304"]')

$fbOld = '<a href="#" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex 
items-center justify-center transition-all" aria-label="Facebook">
              <i class="fa-brands fa-facebook-f text-white text-sm" aria-hidden="true"></i>
            </a>'
$fbNew = '<a href="https://www.facebook.com/profile.php?id=61582846529304" target="_blank" rel="noopener noreferrer" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex items-center justify-center transition-all" aria-label="Facebook">
              <i class="fa-brands fa-facebook-f text-white text-sm" aria-hidden="true"></i>
            </a>'
# PowerShell Replace with multiline strings is tricky. We'll use regex for the footer links.

$content = $content -replace '<a href="#" class="([^"]+) Facebook([^>]+)>\s*<i class="fa-brands fa-facebook-f', '<a href="https://www.facebook.com/profile.php?id=61582846529304" target="_blank" class="$1 Facebook$2>
              <i class="fa-brands fa-facebook-f'

$content = $content -replace '<a href="#" class="([^"]+) Instagram([^>]+)>\s*<i class="fa-brands fa-instagram', '<a href="https://www.instagram.com/invites/contact/?utm_source=ig_contact_invite&utm_medium=copy_link&utm_content=zs1r2dc" target="_blank" title="Follow us @ongerachildrenshome" class="$1 Instagram$2>
              <i class="fa-brands fa-instagram'

$content = $content.Replace("60+ orphans", "30+ orphans")
$content = $content.Replace("60+ resident orphans", "30+ resident orphans")
$content = $content.Replace(">60+<", ">30+<")
$content = $content.Replace("data-target=`"60`"", "data-target=`"30`"")
$content = $content.Replace("60+ Orphans Welcomed", "30+ Orphans Welcomed")
$content = $content.Replace("More than 60", "More than 30")

$content = $content.Replace("240+ day scholars", "170+ day scholars")
$content = $content.Replace(">240+<", ">170+<")
$content = $content.Replace("data-target=`"240`"", "data-target=`"170`"")
$content = $content.Replace("240+ Day Scholars", "170+ Day Scholars")
$content = $content.Replace("More than 240", "More than 170")

$content = $content.Replace("Excel Beyond the Sky", "NATURING HEARTS AND BUILDING FUTURES")
$content = $content.Replace("Bring change to all mankind", "BRING CHANGE TO THE COMMUNITY")

$content = $content.Replace("data-target=`"20`"", "data-target=`"7`"")
$content = $content.Replace(">20+<", ">7<")

$content = $content.Replace('src="images/poultry.jpg" alt="Poultry farming', 'src="images/maize.jpg" alt="Maize farming')

$ctaOld = '<div class="flex items-center gap-3">
          <a href="#donate"'
$ctaNew = '<div class="flex items-center gap-3">
          <a href="#newsletter" class="hidden sm:inline-flex text-white hover:text-orange-400 p-2 transition-colors" aria-label="Newsletter" title="Newsletter">
            <i class="fa-solid fa-envelope text-xl"></i>
          </a>
          <a href="#donate"'
$content = $content.Replace($ctaOld, $ctaNew)

$vanHtml = '
          <!-- Van Project -->
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
        </div>'

$content = $content -replace '(</article>\s*</div>\s*</div>)', ('</article>' + $vanHtml + '</div>')

[IO.File]::WriteAllText("index.html", $content)
