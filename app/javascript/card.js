const pay = () => {
  const form = document.getElementById("charge-form");
  const submit = document.getElementById("button");

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    submit.disabled = true;

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      } else {
        const errorMessage = document.getElementById("card-errors");
        errorMessage.textContent = response.error.message;
        submit.disabled = false;
        return;
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay); 