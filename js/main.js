fetch('data/projects.json')
  .then(res => res.json())
  .then(data => {
    const container = document.querySelector('#projects .grid');
    container.innerHTML = '';
    data.forEach(p => {
      const div = document.createElement('div');
      div.className = 'p-4 shadow rounded-2xl hover:shadow-xl transition';
      div.innerHTML = `
        <img src="${p.img}" class="w-full h-48 object-cover rounded-xl"/>
        <h3 class="font-semibold mt-2">${p.title}</h3>
        <p class="text-sm text-slate-600 mt-1">${p.tag}</p>
        <div class="mt-2 flex gap-2">
          <a href="${p.repo}" class="text-amber-600">Repo</a>
          <a href="${p.live}" class="text-amber-600">Live</a>
        </div>
      `;
      container.appendChild(div);
    });
  });
