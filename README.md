<h1 class="code-line" data-line-start=0 data-line-end=1 ><a id="OmniNews_0"></a>BrightOCR</h1>

**Important**: For the app to work firebase configuration file is required which is not included in the repo. If it wasn't sent to you by the author of this repository (it would be me ;) ) then you need to create one yourself. To do so please follow  <a href="https://firebase.google.com/docs/ios/setup">this link (step 1 - 3)</a>.

PS Please remember about `pod install` :) 
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Part of the App</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr>
<td>Architecture</td>
<td>MVVM+C, CoreData, FileManager</td>
</tr>
<tr>
<td>Views</td>
<td>Code only, Autolayout (EasyPeasy), no storyboards/XIBs</td>
</tr>
<tr>
<td>Dependency manager</td>
<td>CocoaPods</td>
</tr>
<tr>
<td>Test frameworks</td>
<td>Not included</td>
</tr>
<tr>
<td>Other dependencies</td>
<td>GoogleMLKit, SwiftLint</td>
</tr>
<tr>
<td>Additional Info</td>
<td>Supports Dark Mode, Camera and Gallery sources, Records can be removed</td>
</tr>
</tbody>
</table>
<ul>
<li class="has-line-data" data-line-start="10" data-line-end="11">Based on research I decided to use MLKit from firebase to perform OCR. I have experience in Tesseract and OpenCV on android systems but MLKit seems to provide better results, is easier to implement, and seems more stable. <a href="https://heartbeat.fritz.ai/comparing-on-device-text-recognition-ocr-sdks-24f8a0423461">Source</a></li>
<li class="has-line-data" data-line-start="10" data-line-end="11">For persistence, I used CoreData to store basic info about the record (date, UUID, text) and FileManager to store the image itself (path is computed based on UUID). I considered using Realm but this dependency is in my opinion way too heavy for the task given.,</li>
<li class="has-line-data" data-line-start="11" data-line-end="12">The application supports the dynamic transition between dark and light modes, choosing a source of the image (gallery and camera), asking the user for permission (showing information to go to settings if user previous denied permission is not included), removing added records (clearing list, database and image file), updating list after adding a new record.</li>
<li class="has-line-data" data-line-start="12" data-line-end="13">I left some comments in the app in catch blocks, marking places where Logger in the production app normally would be attached.</li>
<li class="has-line-data" data-line-start="14" data-line-end="15">Tests are not included as they were not explicitly required, and with the app of this size, I used the time given to play around with dark mode ;),</li>
<li class="has-line-data" data-line-start="15" data-line-end="16">Normally I would include RxSwift for binding viewModels with ViewControllers and creating streams (eg. performing OCR and saving the result to the database) but again, with the app of this size it would overcomplicate things, delegates and closures seemed good enough.</li>
