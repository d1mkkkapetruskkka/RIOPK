import { Injectable } from '@angular/core';

const TOKEN = 's_token';
const USER = 's_user';

@Injectable({
  providedIn: 'root'
})
export class UserStoargeService {

  constructor() { }

  public saveToken(token: string): void {
    if (typeof window !== 'undefined') {
      window.localStorage.removeItem(TOKEN);
      window.localStorage.setItem(TOKEN, token);
    }
  }

  static getToken(): string | null {
    if (typeof window !== 'undefined') {
      return localStorage.getItem(TOKEN);
    }
    return null;
  }

  public saveUser(user): void {
    if (typeof window !== 'undefined') {
      window.localStorage.removeItem(USER);
      window.localStorage.setItem(USER, JSON.stringify(user));
    }
  }

  static getUser(): any {
    if (typeof window !== 'undefined') {
      return JSON.parse(localStorage.getItem(USER) || 'null');
    }
    return null;
  }

  static getUserId(): string {
    const user = this.getUser();
    return user ? user.userId : '';
  }

  static getUserRole(): string {
    const user = this.getUser();
    return user ? user.role : '';
  }

  static isClientLoggedIn(): boolean {
    return this.getToken() !== null && this.getUserRole() === 'CLIENT';
  }

  static isCompanyLoggedIn(): boolean {
    return this.getToken() !== null && this.getUserRole() === 'COMPANY';
  }

  static signOut(): void {
    if (typeof window !== 'undefined') {
      window.localStorage.removeItem(TOKEN);
      window.localStorage.removeItem(USER);
    }
  }
}