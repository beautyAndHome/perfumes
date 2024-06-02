import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {
  title = 'beautyandhome';
  logo = 'https://i.postimg.cc/jjsmSGJd/bah-logo.png'

  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  redirect(path: string){
    this.router.navigate([path]);
  }
}
