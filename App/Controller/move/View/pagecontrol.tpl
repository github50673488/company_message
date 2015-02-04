<!--  Page Control   ↓                   -->	

	    <center>
	    			<?php if (isset($this->formBean[URL_LIST][$this->formBean[TOP_PAGE]]) && $this->formBean[URL_LIST][$this->formBean[TOP_PAGE]] != ""): ?>
	    			<a href="" onclick="chg_page('<?php echo $this->formBean[URL_LIST][$this->formBean[TOP_PAGE]]; ?>
');return false;">先頭</a>&nbsp;
                    <?php endif; ?>
                    <?php if (isset($this->formBean[URL_LIST][$this->formBean[PREV_PAGE]]) && $this->formBean[URL_LIST][$this->formBean[PREV_PAGE]] != ""): ?>
                    <a href="" onclick="chg_page('<?php echo $this->formBean[URL_LIST][$this->formBean[PREV_PAGE]]; ?>
');return false;">前</a>&nbsp;
                    <?php endif; ?>

                    <?php $_from = $this->formBean[URL_LIST]; 
					if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }
					$this->foreachArray['urlloop'] = array('total' => count($_from), 'iteration' => 0);
                    if ($this->foreachArray['urlloop']['total'] > 0):
                    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
                       $this->foreachArray['urlloop']['iteration']++;
?>
                    <?php if ($this->formBean['key'] == $this->formBean[NOW_PAGE]): ?>
                    <?php echo $this->formBean['key']; ?>
                    <?php elseif ($this->formBean['key'] != $this->formBean[TOP_PAGE] && $this->formBean['key'] != $this->formBean[PREV_PAGE] && $this->formBean['key'] != $this->formBean[NEXT_PAGE] && $this->formBean['key'] != $this->formBean[LAST_PAGE]): ?>
                    <a href="" onclick="chg_page('<?php echo $this->formBean['value']; ?>
');return false;" accesskey="<?php echo $this->formBean['key']; ?>"><?php echo $this->formBean['key']; ?></a>&nbsp;
                    <?php endif; ?>
                    <?php endforeach; endif; unset($_from); ?>

                    <?php if (isset($this->formBean[URL_LIST][$this->formBean[NEXT_PAGE]]) && $this->formBean[URL_LIST][$this->formBean[NEXT_PAGE]] != ""): ?>
                    <a href="" onclick="chg_page('<?php echo $this->formBean[URL_LIST][$this->formBean[NEXT_PAGE]]; ?>
');return false;">次</a>&nbsp;
                    <?php endif; ?>
                    <?php if (isset($this->formBean[URL_LIST][$this->formBean[LAST_PAGE]]) && $this->formBean[URL_LIST][$this->formBean[LAST_PAGE]] != ""): ?>
                    <a href="" onclick="chg_page('<?php echo $this->formBean[URL_LIST][$this->formBean[LAST_PAGE]]; ?>
');return false;">最後</a>&nbsp;
                    <?php endif; ?>
                    
</center>

	     <form action="" method="post" name="form1" id="paramform">
               <input type="hidden" name="pageCount" value="<?php echo $this->formBean['pageCount']; ?>" /> 
         </form>
                

	<!--  Page Control   ↑                   -->			