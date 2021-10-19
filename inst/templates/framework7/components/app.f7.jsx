export default (props, { $f7 }) => {
  const title = 'Hello World';
  
  return () => (
    <div id="app">
      <div class="view view-main view-init safe-areas">
        <div class="page">
          <div class="navbar">
            <div class="navbar-bg"></div>
            <div class="navbar-inner">
              <div class="title">{title}</div>
            </div>
          </div>
          <div class="toolbar toolbar-bottom">
            <div class="toolbar-inner">
              <a href="#" >Link 1</a>
              <a href="#" >Link 2</a>
            </div>
          </div>
          <div class="page-content">
            <div class="block strong">
              Page Content
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
