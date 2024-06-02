import { Component, ElementRef, OnInit } from '@angular/core';
import { OrdineCompleto, OrdineProdotto, PaypalResponseModel, Prodotto } from 'src/app/model/models';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Ordine } from 'src/app/model/models';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss'],
})
export class CartComponent implements OnInit {
  isCartFormValid: boolean = false;
  isCheckedOut: boolean = false;

  cart: Prodotto[] = [];
  selectedPaymentMethod: string | undefined;
  paymentForm: any = {
    nome: '',
    cognome: '',
    via: '',
    cap: '',
    comune: '',
    provincia: '',
    telefono: '',
    email: '',
  };

  isShowPaypalSection: boolean = false;

  constructor(private http: HttpClient, private el: ElementRef) {}

  ngOnInit(): void {
    this.getCart();
    this.handleScroll();
  }

  handleScroll() {
    const observer = new MutationObserver(() => {
      window.scrollTo(0, document.body.scrollHeight);
    });
    observer.observe(this.el.nativeElement, { childList: true, subtree: true });
  }

  checkFormValidation() {
    if (
      !(
        this.paymentForm?.nome &&
        this.paymentForm?.cognome &&
        this.paymentForm?.via &&
        this.paymentForm?.cap &&
        this.paymentForm?.comune &&
        this.paymentForm?.provincia &&
        this.paymentForm?.telefono
      )
    ) {
      this.isCartFormValid = false;
    } else {
      this.isCartFormValid = true;
    }
  }

  getCart() {
    this.cart = JSON.parse(sessionStorage.getItem('cartItems') || '[]');
  }

  removeProduct(prodotto: Prodotto) {
    if (prodotto !== undefined) {
      const cartProduct = this.cart.find((obj) => obj.id === prodotto.id);
      if (
        cartProduct?.quantitaInCarrello &&
        cartProduct?.quantitaInCarrello != 1
      ) {
        cartProduct.quantitaInCarrello = cartProduct.quantitaInCarrello - 1;
      } else {
        const index = this.cart.indexOf(prodotto);
        if (index !== -1) {
          this.cart.splice(index, 1);
        }
      }
      sessionStorage.setItem('cartItems', JSON.stringify(this.cart));
    }
  }

  getTotalPrice(): number {
    let totalPrice = 0;
    for (const product of this.cart) {
      if (
        product.quantitaInCarrello !== undefined &&
        product.prezzo !== undefined
      ) {
        totalPrice += product.prezzo * product.quantitaInCarrello;
      }
    }
    return totalPrice;
  }

  onClickProcessPayment(){
    if(this.selectedPaymentMethod === 'contrassegno'){
      this.processPayment();
    } else if(this.selectedPaymentMethod=== 'paypal') {
      this.showPaypalSection();
    }
  }

  showPaypalSection(){
    this.isShowPaypalSection = true;
  }

  processPayment(event?: PaypalResponseModel): void {

    console.log(event);

    const ordineSpedizione: Ordine = {
      nome: this.paymentForm.nome,
      cognome: this.paymentForm.cognome,
      indirizzo: this.paymentForm.via,
      cap: this.paymentForm.cap,
      comune: this.paymentForm.comune,
      provincia: this.paymentForm.provincia,
      telefono: this.paymentForm.telefono,
      email: this.paymentForm.email,
      dataOrdine: new Date(),
      totale: this.getTotalPrice(),
      metodoPagamento: event?.data?.paymentSource ? event?.data?.paymentSource : this.selectedPaymentMethod,
    };

    let ordineDettaglio: OrdineProdotto[] = [];

    this.cart.forEach((prodotto) => {
      ordineDettaglio.push({
        prodottoId: prodotto.id,
        quantita: prodotto.quantitaInCarrello,
      });
    });

    const ordineCompleto: OrdineCompleto = {
      ordine: ordineSpedizione,
      ordineProdotti: ordineDettaglio,
    };

    this.http
      .post<any>(`${environment.apiUrl}/api/ordini`, ordineCompleto)
      .subscribe((res) => {
        console.log('Ordine completato con successo:', res);

        // Rimuovi i prodotti dal carrello dopo aver completato l'ordine
        this.cart = [];
        sessionStorage.removeItem('cartItems');
        this.isCheckedOut = true;
      });
  }

  goToBottom() {
    window.scrollTo(0, document.body.scrollHeight);
  }
}
