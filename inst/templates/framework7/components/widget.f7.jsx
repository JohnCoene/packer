const Widget = (props, { $f7, $update }) => {
  // Handle range change for ODE model computation
  const getRangeValue = (e) => {
    const range = $f7.range.get(e.target);
    Shiny.setInputValue(range.el.id + '_value', range.value);
    $update();
  };

  return () => (
    <div>
      <div class="block-title">Widget label</div>
      <div class="block">
        <div
          class="range-slider range-slider-init"
          data-min="0"
          data-min="0"
          data-max="2"
          data-step="0.1"
          data-label="true"
          data-value="0.1"
          data-scale="true"
          data-scale-steps="2"
          data-scale-sub-steps="10"
          id="slider"
          onrangeChange={(e) => getRangeValue(e)}
          ></div>
      </div>  
    </div>
  )
}

const initializeWidget = (app) => {
  $(document).on('shiny:connected', () => {
    // initial value
    Shiny.setInputValue(
        'slider_value', 
        parseFloat($('#slider').attr('data-value'), 10), 
        {priority: 'event'}
    );
  });
}

export { Widget, initializeWidget };
