// ...existing code...
document.addEventListener('DOMContentLoaded', function () {
  // GridStack is provided globally by gridstack-all.js included in your HTML
  var grid = GridStack.init({}, '.grid-stack');

  // add a widget (HTML string is accepted)
  grid.addWidget(`
    <div class="grid-stack-item" gs-w="2" gs-h="2">
      <div class="grid-stack-item-content">Item 1</div>
    </div>
  `);
});
// ...existing code...