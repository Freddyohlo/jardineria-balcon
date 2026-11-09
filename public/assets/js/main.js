// Mejora progresiva: marca el enlace de navegación activo según la URL actual.
(function () {
  var ruta = location.pathname.replace(/index\.html$/, "");
  var enlaces = document.querySelectorAll(".cabecera__nav a");
  enlaces.forEach(function (a) {
    var destino = a.getAttribute("href");
    if (destino === ruta || (destino !== "/" && ruta.indexOf(destino) === 0)) {
      a.setAttribute("aria-current", "page");
    }
  });
})();
