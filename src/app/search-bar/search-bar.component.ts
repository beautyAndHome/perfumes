import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-search-bar',
  templateUrl: './search-bar.component.html',
  styleUrls: ['./search-bar.component.scss']
})
export class SearchBarComponent {
  @Output() searchInput = new EventEmitter<string>();

  onInput(event: any): void {
    const searchTerm = (event.target as HTMLInputElement).value;
    this.searchInput.emit(searchTerm);
  }

  
}
