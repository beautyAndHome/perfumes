import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Prodotto } from 'src/app/model/models';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { map } from 'rxjs';

@Component({
  selector: 'app-product-details',
  templateUrl: './product-details.component.html',
  styleUrls: ['./product-details.component.scss'],
})
export class ProductDetailsComponent implements OnInit {
  apiUrl = `${environment.apiUrl}/api/prodotti`; // Modifica con l'URL effettivo della tua API
  productId: string | undefined;
  product: Prodotto = {};

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private http: HttpClient
  ) {}

  ngOnInit(): void {
    this.productId = this.route.snapshot.queryParams['id']; // Ottieni l'ID del prodotto dalla URL
    this.getProdottoById();
  }
  getProdottoById(): void {
    const url = `${environment.apiUrl}/api/prodotti/details?id=${this.productId}`;

    this.http
      .get<Prodotto[]>(url)
      .pipe(
        map((response) => response as Prodotto[]) // Aggiungi map per convertire la risposta in formato JSON
      )
      .subscribe(
        (response) => {
          console.log(response);
          this.product = response[0];
          console.log(this.product);
        },
        (error) => {
          console.error('Errore durante il recupero dei prodotti:', error);
        }
      );
  }

  getProductById(productId: string): void {
    this.http
      .get<Prodotto>(`${this.apiUrl}/${productId}`)
      .pipe(
        map((response) => response as Prodotto) // Aggiungi map per convertire la risposta in formato JSON
      )
      .subscribe((product) => {
        this.product = product;
      });
  }

  addToCart(prodotto: Prodotto): void {
    let cart: Prodotto[] = JSON.parse(
      sessionStorage.getItem('cartItems') || '[]'
    );
    let cartProduct = cart.find((obj) => obj.id === prodotto.id);
    if (cartProduct?.quantitaInCarrello) {
      cartProduct.quantitaInCarrello = cartProduct.quantitaInCarrello + 1;
    } else {
      cartProduct = prodotto;
      cartProduct.quantitaInCarrello = 1;
      cart.push(cartProduct);
    }
    sessionStorage.setItem('cartItems', JSON.stringify(cart));
    sessionStorage.setItem('lastAddedCartItem', JSON.stringify(cartProduct));
    console.log('Prodotto aggiunto al carrello!');
    this.router.navigate(['/cart-added']);
  }

  redirectToCheckout(prodotto: Prodotto): void {
    this.router.navigate(['/checkout']);
  }
  
}
