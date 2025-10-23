import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ClientRoutingModule } from './client-routing.module';
import { ClientComponent } from './client.component';
import { DemoNgZorroAntdModule } from '../DemoNgZorroAntdModule';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CatalogComponent } from './pages/catalog/catalog.component';
import { AdDetailComponent } from './pages/ad-detail/ad-detail.component';
import { ReviewComponent } from './pages/review/review.component';


@NgModule({
  declarations: [
    ClientComponent,
    CatalogComponent,
    AdDetailComponent,
    ReviewComponent
  ],
  imports: [
    CommonModule,
    ClientRoutingModule,
    DemoNgZorroAntdModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class ClientModule { }
