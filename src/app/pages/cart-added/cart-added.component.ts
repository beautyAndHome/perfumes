import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Prodotto } from 'src/app/model/models';

@Component({
  selector: 'app-cart-added',
  templateUrl: './cart-added.component.html',
  styleUrls: ['./cart-added.component.scss'],
})
export class CartAddedComponent implements OnInit {
  lastItemCartAdded: Prodotto = {};

  constructor(private router: Router) {}

  ngOnInit(): void {
    this.lastItemCartAdded = JSON.parse(
      sessionStorage.getItem('lastAddedCartItem') || '{}'
    );
  }

  redirect(path: string) {
    this.router.navigate([path]);
  }
}
