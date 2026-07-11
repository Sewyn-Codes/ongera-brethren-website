import re

def update_file():
    with open('index.html', 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Email replacements
    content = content.replace('info@ongerabrethren.org', 'ongerainternationalorganization@gmail.com')

    # 2. Facebook and Instagram Links
    content = content.replace('"sameAs": ["https://www.facebook.com/ongerabrethren"]', '"sameAs": ["https://www.facebook.com/profile.php?id=61582846529304"]')
    
    # Update social links in footer (around line 1180)
    # The current a tags for facebook and instagram have href="#"
    fb_link_block = '''<a href="#" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex items-center justify-center transition-all" aria-label="Facebook">
              <i class="fa-brands fa-facebook-f text-white text-sm" aria-hidden="true"></i>
            </a>'''
    fb_link_new = '''<a href="https://www.facebook.com/profile.php?id=61582846529304" target="_blank" rel="noopener noreferrer" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex items-center justify-center transition-all" aria-label="Facebook">
              <i class="fa-brands fa-facebook-f text-white text-sm" aria-hidden="true"></i>
            </a>'''
    content = content.replace(fb_link_block, fb_link_new)

    ig_link_block = '''<a href="#" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex items-center justify-center transition-all" aria-label="Instagram">
              <i class="fa-brands fa-instagram text-white text-sm" aria-hidden="true"></i>
            </a>'''
    ig_link_new = '''<a href="https://www.instagram.com/invites/contact/?utm_source=ig_contact_invite&utm_medium=copy_link&utm_content=zs1r2dc" title="Follow us @ongerachildrenshome" target="_blank" rel="noopener noreferrer" class="w-10 h-10 rounded-xl bg-white/10 hover:bg-orange-500 flex items-center justify-center transition-all" aria-label="Instagram">
              <i class="fa-brands fa-instagram text-white text-sm" aria-hidden="true"></i>
            </a>'''
    content = content.replace(ig_link_block, ig_link_new)

    # 3. 60+ Orphans -> 30+ Orphans
    content = content.replace('60+ orphans', '30+ orphans')
    content = content.replace('60+ resident orphans', '30+ resident orphans')
    content = content.replace('60+ Orphans', '30+ Orphans')
    content = content.replace('>60+<', '>30+<')
    content = content.replace('data-target="60"', 'data-target="30"')
    content = content.replace('More than 60', 'More than 30')

    # 4. 240+ Day Scholars -> 170+ Day Scholars
    content = content.replace('240+ day scholars', '170+ day scholars')
    content = content.replace('240+ Day Scholars', '170+ Day Scholars')
    content = content.replace('>240+<', '>170+<')
    content = content.replace('data-target="240"', 'data-target="170"')
    content = content.replace('More than 240', 'More than 170')

    # 5. Motto & Vision
    content = content.replace('"Excel Beyond the Sky"', '"NATURING HEARTS AND BUILDING FUTURES"')
    content = content.replace('"Bring change to all mankind"', '"BRING CHANGE TO THE COMMUNITY"')

    # 6. Active Projects: 20+ -> 7
    content = content.replace('data-target="20"', 'data-target="7"')
    content = content.replace('>20+<', '>7<')

    # 7. Agriculture Project Image
    content = content.replace('src="images/poultry.jpg" alt="Poultry farming for the agriculture project"', 'src="images/maize.jpg" alt="Maize farming for the agriculture project"')

    # 8. Newsletter icon in header
    # Find CTA block
    cta_block = '''<div class="flex items-center gap-3">
          <a href="#donate"'''
    new_cta_block = '''<div class="flex items-center gap-3">
          <a href="#newsletter" class="inline-flex items-center justify-center text-white hover:text-orange-400 p-2 transition-colors rounded-full" aria-label="Newsletter" title="Subscribe to our Newsletter">
            <i class="fa-solid fa-envelope text-xl" aria-hidden="true"></i>
          </a>
          <a href="#donate"'''
    content = content.replace(cta_block, new_cta_block)

    # 9. Add Van project
    # Find the end of the project grid
    # Looking for the last project-card in the grid
    # A bit tricky, let's look for the end of the projects grid. 
    # It's a grid with a bunch of articles. Let's find:
    # "Message to Fund\n              </a>\n            </div>\n          </article>\n\n        </div>"
    # Actually, the grid starts with `<div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-7">`
    # and ends with `</div>` just before `<div class="mt-16 text-center reveal">`
    
    van_html = '''
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
'''
    
    # We can inject this van project just before the closing div of the grid.
    # The grid structure looks like:
    #         </div>
    #       </article>
    #     </div>
    #     <!-- Call to Action / View All -->
    # We can do this with regex.
    grid_end_pattern = r'(</article>\s*)(</div>\s*<!-- View All / CTA for projects)'
    if not re.search(grid_end_pattern, content):
        # Alternative pattern: look for the closing div before `<div class="mt-16 text-center reveal">` in the projects section
        grid_end_pattern_alt = r'(</article>\s*)(</div>\s*<div class="mt-16 text-center reveal">)'
        content = re.sub(grid_end_pattern_alt, r'\1' + van_html + r'\2', content)

    with open('index.html', 'w', encoding='utf-8') as f:
        f.write(content)

update_file()
print("Done")
