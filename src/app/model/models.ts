export interface OrdineProdotto {
    prodottoId: number | undefined;
    quantita: number | undefined;
  }

  export interface OrdineCompleto {
    ordine: Ordine;
    ordineProdotti: OrdineProdotto[];
  }

  export interface Ordine {
    id?: number;
    nome?: string;
    cognome?: string;
    indirizzo?: string;
    cap?: string;
    provincia?: string;
    comune?: string;
    telefono?: string;
    email?: string;
    dataOrdine?: Date;
    totale?: number;
    metodoPagamento?: string;
  }

  export interface Prodotto {
    id?: number;
    nome?: string;
    descrizione?: string;
    prezzo?: number;
    marca?: string;
    ml?: number;
    categoria?: string;
    immagine?: string;
    quantitaInCarrello?: number;
  }
  
  export interface PreviewImageStyle {
    left?: string;
    top?: string;
  }
  
  export interface PaypalResponseModel {
    data?: {
      orderID?: string
      payerID?: string
      paymentID?: string
      billingToken?: any
      facilitatorAccessToken?: string
      paymentSource?: string
    }
    order?: {
      id?: string
      intent?: string
      status?: string
      purchase_units?: Array<{
        reference_id?: string
        amount?: {
          currency_code?: string
          value?: string
        }
        payee?: {
          email_address?: string
          merchant_id?: string
        }
        soft_descriptor?: string
        shipping?: {
          name?: {
            full_name?: string
          }
          address?: {
            address_line_1?: string
            admin_area_2?: string
            admin_area_1?: string
            postal_code?: string
            country_code?: string
          }
        }
        payments?: {
          captures?: Array<{
            id?: string
            status?: string
            amount?: {
              currency_code?: string
              value?: string
            }
            final_capture?: boolean
            seller_protection?: {
              status?: string
              dispute_categories?: Array<string>
            }
            create_time?: string
            update_time?: string
          }>
        }
      }>
      payer?: {
        name?: {
          given_name?: string
          surname?: string
        }
        email_address?: string
        payer_id?: string
        address?: {
          country_code?: string
        }
      }
      create_time?: string
      update_time?: string
      links?: Array<{
        href?: string
        rel?: string
        method?: string
      }>
    }
  }
  