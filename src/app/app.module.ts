import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { CatalogComponent } from './pages/catalog/catalog.component';
import { ContactsComponent } from './pages/contacts/contacts.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NavbarComponent } from './pages/navbar/navbar.component';
import { LoginComponent } from './pages/login/login.component';
import { FormsModule } from '@angular/forms';
import { SearchBarComponent } from './search-bar/search-bar.component';
import { ProductDetailsComponent } from './pages/product-details/product-details.component';
import { NgrokInterceptor } from './service/NgrockInterceptor.service';
import { CartComponent } from './pages/cart/cart.component';
import { CartAddedComponent } from './pages/cart-added/cart-added.component';
import { CheckoutComponent } from './pages/checkout/checkout.component';
import { PaypalPaymentComponent } from './pages/paypal-payment/paypal-payment.component';

@NgModule({
  declarations: [
    AppComponent,
    CatalogComponent,
    ContactsComponent,
    NavbarComponent,
    LoginComponent,
    SearchBarComponent,
    ProductDetailsComponent,
    CartComponent,
    CartAddedComponent,
    CheckoutComponent,
    PaypalPaymentComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    FormsModule,
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: NgrokInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
