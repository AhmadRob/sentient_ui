// Fallback: ensure handlePaperDownload works when modules or other scripts didn't load
(function(){
  if (window.handlePaperDownload) return; // don't override if main script exists

  window.handlePaperDownload = function(event) {
    try { if (event && event.stopPropagation) event.stopPropagation(); } catch (e) {}
    const filePath = 'assets/Engineering_Sentient_UI__Bridging_Emotion__Behavior__and_Context_for_Dynamic_UI_Adaptation.pdf';
    const filename = filePath.split('/').pop();

    // Try to create a link and click to download
    const link = document.createElement('a');
    link.href = filePath;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    link.remove();

    // As a fallback, open in a new tab
    setTimeout(() => {
      if (!document.hidden) return;
      window.open(filePath, '_blank');
    }, 500);
  };
})();