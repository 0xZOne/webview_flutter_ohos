/*
* Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import { Reply, WebViewClientHostApi } from './GeneratedOhosWebView';
import { InstanceManager } from './InstanceManager';
import { WebViewClientFlutterApiImpl } from './WebViewClientFlutterApiImpl';
import { WebViewPlatformView } from './WebViewHostApiImpl';

export interface WebViewClient {
  onPageStarted(view: WebViewPlatformView, url: string): void;

  onPageFinished(view: WebViewPlatformView, url: string): void;

  onReceivedError(view: WebViewPlatformView, request: WebResourceRequest, error: WebResourceError): void;

  shouldOverrideUrlLoading(view: WebViewPlatformView, request: WebResourceRequest): boolean;

  doUpdateVisitedHistory(view: WebViewPlatformView, url: string, isReload: boolean): void;
}

export class WebViewClientImpl implements WebViewClient {
  private flutterApi: WebViewClientFlutterApiImpl;
  private returnValueForShouldOverrideUrlLoading: boolean = false;
  private emptyReply: Reply<void> = {
    reply: (reply) => {
    }
  }

  constructor(flutterApi: WebViewClientFlutterApiImpl) {
    this.flutterApi = flutterApi;
  }

  onPageStarted(view: WebViewPlatformView, url: string) {
    this.flutterApi.onPageStartedImpl(this, view, url, this.emptyReply);
  }

  onPageFinished(view: WebViewPlatformView, url: string) {
    this.flutterApi.onPageFinishedImpl(this, view, url, this.emptyReply);
  }

  onReceivedError(view: WebViewPlatformView, request: WebResourceRequest, error: WebResourceError) {
    this.flutterApi.onReceivedRequestErrorImpl(this, view, request, error, this.emptyReply);
  }

  shouldOverrideUrlLoading(view: WebViewPlatformView, request: WebResourceRequest): boolean {
    if(this.returnValueForShouldOverrideUrlLoading && request.isRequestGesture()){
      this.flutterApi.requestLoadingImpl(this, view, request, this.emptyReply)
      return true;
    }
    return false
  }

  doUpdateVisitedHistory(view: WebViewPlatformView, url: string, isReload: boolean) {
    this.flutterApi.doUpdateVisitedHistoryImpl(this, view, url, isReload, this.emptyReply);
  }

  setReturnValueForShouldOverrideUrlLoading(value: boolean) {
    this.returnValueForShouldOverrideUrlLoading = value;
  }
}

export class WebViewClientCreator {
  createWebViewClient(flutterApi: WebViewClientFlutterApiImpl): WebViewClient {
    return new WebViewClientImpl(flutterApi);
  }
}

export class WebViewClientHostApiImpl extends WebViewClientHostApi {
  private instanceManager: InstanceManager;
  private webViewClientCreator: WebViewClientCreator;
  private flutterApi: WebViewClientFlutterApiImpl;

  constructor(
    instanceManager: InstanceManager,
    webViewClientCreator: WebViewClientCreator,
    flutterApi: WebViewClientFlutterApiImpl
  ) {
    super();
    this.instanceManager = instanceManager;
    this.webViewClientCreator = webViewClientCreator;
    this.flutterApi = flutterApi;
  }

  create(instanceId: number) {
    const webViewClient: WebViewClient = this.webViewClientCreator.createWebViewClient(this.flutterApi);
    this.instanceManager.addDartCreatedInstance(webViewClient, instanceId);
  }

  setSynchronousReturnValueForShouldOverrideUrlLoading(instanceId: number, value: boolean) {
    const webViewClient: WebViewClient = this.instanceManager.getInstance(instanceId);
    if (webViewClient instanceof WebViewClientImpl) {
      webViewClient.setReturnValueForShouldOverrideUrlLoading(value);
    } else {
      throw new Error("This WebViewClient doesn't support setting the returnValueForShouldOverrideUrlLoading.");
    }
  }
}