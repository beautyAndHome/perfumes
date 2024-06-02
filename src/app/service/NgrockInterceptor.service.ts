import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpHandler, HttpRequest } from '@angular/common/http';

@Injectable()
export class NgrokInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<any>, next: HttpHandler) {
    // Clone the request and add the ngrok-skip-browser-warning header
    const modifiedReq = req.clone({
      setHeaders: {
        'ngrok-skip-browser-warning': 'true'
      }
    });
    // Pass the modified request to the next handler
    return next.handle(modifiedReq);
  }
}