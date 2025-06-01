const price = () => {                              
  const priceInput = document.getElementById('item-price');

  if (!priceInput) {
    return;
  }
  
  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    
    if (inputValue >= 300 && inputValue <= 9999999) {
      const addTaxDom = document.getElementById('add-tax-price');
      const profitDom = document.getElementById('profit');
      const fee = Math.floor(inputValue * 0.1);
      const profit = inputValue - fee;
      addTaxDom.innerHTML = fee;
      profitDom.innerHTML = profit;
    } else {
      const addTaxDom = document.getElementById('add-tax-price');
      const profitDom = document.getElementById('profit');
      addTaxDom.innerHTML = "---";
      profitDom.innerHTML = "---";
    }
  });
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);
