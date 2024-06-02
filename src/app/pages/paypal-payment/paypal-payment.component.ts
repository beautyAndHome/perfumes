import { Component, EventEmitter, Input, Output } from '@angular/core';

@Component({
  selector: 'app-paypal-payment',
  template: '<div id="paypal-button-container"></div>'
})
export class PaypalPaymentComponent {

  @Input() prezzo: number | undefined;
  @Output() paymentSuccess: EventEmitter<any> = new EventEmitter<any>();
  @Output() paymentError: EventEmitter<any> = new EventEmitter<any>();

  constructor() {}

  ngAfterViewInit() {
    paypal.Buttons({
      createOrder: (data: any, actions: any) => {
        console.log(data);
        return actions.order.create({
          purchase_units: [{
            amount: {
              value: this.prezzo // Importo da addebitare
            }
          }]
        });
      },
      onApprove: async (data: any, actions: any) => {
        console.log('pagamento ok',data);
        const order = await actions.order.capture();
        this.paymentSuccess.emit({data: data, order: order});
      },
      onError: (err: any) => {
        console.log('pagamento errore ko',err);
        this.paymentError.emit(err);
      }
    }).render('#paypal-button-container');
  }
}