<form action="submitreports.asp" method="post">
    <fieldset class="form-group">
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="violation" value="Inappropriate or Abusive" id="abusive">
            <label class="form-check-label" for="abusive">
                Inappropriate or Abusive
            </label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="violation" value="Offensive" id="offensive">
            <label class="form-check-label" for="offensive">
                Offensive
            </label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="violation" value="False Information" id="false">
            <label class="form-check-label" for="false">
                False Information
            </label>
        </div>
        <div class="form-group">
            <label for="exampleTextarea" class="form-label mt-4">Others:</label>
            <textarea class="form-control" id="exampleTextarea" rows="3" name="others" spellcheck="false"></textarea>
        </div>
    </fieldset>
</div>
<div class="modal-footer">
    <button type="submit" class="btn btn-primary">Submit</button>
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
</div>
</form>