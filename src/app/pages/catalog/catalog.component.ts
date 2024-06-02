import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { map } from 'rxjs';
import { Prodotto } from 'src/app/model/models';
import { environment } from 'src/environments/environment';

interface PreviewImageStyle {
  left?: string;
  top?: string;
}

@Component({
  selector: 'app-catalog',
  templateUrl: './catalog.component.html',
  styleUrls: ['./catalog.component.scss'],
})
export class CatalogComponent implements OnInit {
  prodotti: Prodotto[] = [];
  prodottiNotFiltered: Prodotto[] = [];
  showPreview = false;
  hoveredImageUrl = '';
  mouseX = 0;
  mouseY = 0;
  selectedCategories: string[] = [];

  fragranzeMaschiliChecked: boolean = false;
  fragranzeFemminiliChecked: boolean = false;
  fragranzeUnisexChecked: boolean = false;

  constructor(private http: HttpClient, private router: Router) {}

  ngOnInit(): void {
    this.getProdottiFiltered();
  }

  getProdottiFiltered() {
    const headers = new HttpHeaders().set('ngrok-skip-browser-warning', 'true');
    let categorie = [];
    let categoria = '';
    if (
      this.fragranzeMaschiliChecked ||
      (!this.fragranzeMaschiliChecked && !this.fragranzeFemminiliChecked && !this.fragranzeUnisexChecked)
    ) {
      categorie.push('Fragranze maschili');
    }
    if (
      this.fragranzeFemminiliChecked ||
      (!this.fragranzeMaschiliChecked && !this.fragranzeFemminiliChecked && !this.fragranzeUnisexChecked)
    ) { 
      categorie.push('Fragranze femminili');
    }
    if (this.fragranzeUnisexChecked||
      (!this.fragranzeMaschiliChecked && !this.fragranzeFemminiliChecked && !this.fragranzeUnisexChecked)
    ) { 
      categorie.push('Fragranze unisex');
    }
  


    categorie.forEach((element, index) => {
      if (index == 0) {
        categoria = categoria.concat(element);
      } else {
        categoria = categoria.concat(',' + element);
      }
    });
  
    const url = `${environment.apiUrl}/api/prodotti/filtered?categoria=${categoria}`;
  
    this.http
      .get<Prodotto[]>(url, { headers })
      .pipe(
        map((response) => response as Prodotto[]) // Aggiungi map per convertire la risposta in formato JSON
      )
      .subscribe(
        (response) => {
          console.log(response);
          this.prodottiNotFiltered = response;
          this.prodotti = response;
          console.log(this.prodotti);
        },
        (error) => {
          console.error('Errore durante il recupero dei prodotti:', error);
        }
      );
  }

  onFragranzeMaschiliChange(event: any) {
    this.fragranzeMaschiliChecked = event.target.checked;
    this.getProdottiFiltered();
    // Use this.fragranzeMaschiliChecked to perform actions based on the checkbox state
  }

  onFragranzeFemminiliChange(event: any) {
    this.fragranzeFemminiliChecked = event.target.checked;
    this.getProdottiFiltered();
    // Use this.fragranzeFemminiliChecked to perform actions based on the checkbox state
  }

  onFragranzeUnisexChange(event: any) {
    this.fragranzeUnisexChecked = event.target.checked;
    this.getProdottiFiltered();
  }

  showPreviewImage(imageUrl: string, event: MouseEvent): void {
    this.showPreview = true;
    this.hoveredImageUrl = imageUrl;

    // Otteniamo le coordinate relative all'elemento padre dell'immagine (td)
    const boundingRect = (event.target as HTMLElement).getBoundingClientRect();
    const offsetX = event.clientX - boundingRect.left;
    const offsetY = event.clientY - boundingRect.top;

    // Aggiungiamo l'offset dello scroll della finestra
    this.mouseX = event.clientX - offsetX;
    this.mouseY = event.clientY - offsetY;
  }

  hidePreviewImage(): void {
    this.showPreview = false;
    this.hoveredImageUrl = '';
  }

  getPreviewImageStyle(): PreviewImageStyle {
    const pageWidth = window.innerWidth;
    const previewImageStyle: PreviewImageStyle = {};

    // Calcoliamo la posizione relativa alla finestra di visualizzazione
    const viewportWidth = document.documentElement.clientWidth;
    const scrollX = window.scrollX || window.pageXOffset;
    const cursorX = this.mouseX - scrollX;

    // Se il cursore è più vicino al bordo destro della finestra di visualizzazione, posiziona l'anteprima a sinistra del cursore
    if (cursorX > viewportWidth / 2) {
      previewImageStyle.left = cursorX - 200 + 'px'; // 200 è la larghezza dell'anteprima immagine
    } else {
      previewImageStyle.left = cursorX + 'px';
    }

    previewImageStyle.top = this.mouseY + 'px';

    return previewImageStyle;
  }

  searchProducts(searchTerm: string): void {
    if (searchTerm.trim() !== '') {
      // Effettua la ricerca solo se il termine di ricerca non è vuoto
      this.prodotti = this.prodottiNotFiltered.filter((prodotto) =>
        prodotto?.nome?.toLowerCase().includes(searchTerm.toLowerCase())
      );
    } else {
      // Se il termine di ricerca è vuoto, ripristina la lista completa dei prodotti
      this.getProdottiFiltered();
    }
  }

  onProductSelected(id: number) {
    this.router.navigate(['/catalog/details'], { queryParams: { id: id } }); // Navigation with query param
  }
}
